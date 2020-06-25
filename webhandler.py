import requests
from bs4 import BeautifulSoup
import azureKey
from azure.ai.textanalytics import TextAnalyticsClient
from azure.core.credentials import AzureKeyCredential
from textPredictors import TextPredicor
import numpy as np


# the reason I'm using  '|' in my urls instead of '/' is because i want to pass
# my url within the api request url... That's why i need to do preprocessing
# The chrome extension will convert the url to use '|' before an API call

class WebProcessor:

    def getUrlData(self, urlString):
        textPredictor = TextPredicor()
        azureClient = self.authenticate_client()

        url = self._cleanUrl(urlString)
        mainUrlData = self._getData(url, getError = True)

        mainHeadline = mainUrlData.get("headline")
        mainText = mainUrlData.get("text")

        try:  # jank sollution to checking if there was an error
            if 'error' in mainHeadline.keys():
                return mainHeadline
        except :
            pass

        readingScores = textPredictor.getTextResults(mainText)
        mainReadability = readingScores.get("readability")
        mainReadingTime = readingScores.get("readTime")
        mainSentiment = self._getSentiment(azureClient, self.trimAzure(mainText)) 
        

        #get other relevant news articles
        relatedNewsUrls = self._google(mainHeadline)
        relatedNewsUrls = relatedNewsUrls[0:5] # keep only 5
        relatedNews = []
        for rurl in relatedNewsUrls:
            if rurl != url: #avoid duplicate urls
                data = self._getData("https://"+rurl)
                if data != "error":
                    headline = data.get("headline").strip()
                    text = data.get("text")
                    readingscore = textPredictor.getTextResults(text)
                    readability = readingscore.get("readability")
                    readingTime = readingscore.get("readTime")
                    sentiment = 0.5
                    # sentiment = self._getSentiment(
                    #     azureClient, self.trimAzure(text))
                    relatedNews.append({
                        "url": rurl,
                        "text": text,
                        "readability": readability,
                        "readingTime": readingTime,
                        "headline":headline,
                        "sentiment": sentiment
                    })
        
        rating = self._getRating(relatedNews, mainReadability, mainReadingTime, mainSentiment)
        
        toReturn = {
                    "headline": mainHeadline,
                    "maintext": mainText,
                    "relatedNews": relatedNews,
                    "sentiment": mainSentiment,
                    "rating": rating,
                    "error": "none",
                    }
        return toReturn

    def _cleanUrl(self, dirtyUrl):
        urlClean = dirtyUrl.replace("|" ,"/")
        return urlClean

    def _getData(self, url, getError=False):
        page = requests.get(url)
        if page.status_code != 200:
            toRet = {"error": page.status_code} if getError else "error"
            return toRet

        soup = BeautifulSoup(page.content,'html.parser')
        
        headline = soup.find_all('h1')
        headline = headline[0].text if len(headline) != 0 else "No Headline"

        text = self.getText(soup)

        return {
            "headline": headline,
            "text": text,
            }

    def _google(self, query):
        googleUrl= "https://www.google.com/search?client=ubuntu&channel=fs&q=" + query + "&ie=utf-8&oe=utf-8"
        results = requests.get(googleUrl)
        googleSoup = BeautifulSoup(results.content, 'html.parser')
        urlResults = []

        #I got this div via a inspect elment. Apparently this class 'ZINbbc'
        #has been around since 2018 so hopefully it doesn't deprecate soon...
        for link in googleSoup.find_all('div', attrs = {'class': 'ZINbbc'}):
            try:
                url = link.find("a", href = True)
                urlResults.append(url['href'])
            except:
                pass
        return self._urlResultCleanup(urlResults)
    
    def _urlResultCleanup(self, urlResults):
        cleanedUrls = []
        for url in urlResults:
            #remove the random stuff google adds before https
            #Yeah it also removes https:// but that doesn't affect
            #my usecase so it doesn't matter
            cleaned = url.partition("https://")[-1]
            #the & is the junk google adds at the end of urls
            cleaned = cleaned.partition("&")[0]

            #filter out some random empty urls i was getting
            if len(cleaned) > 10: 
                cleanedUrls.append(cleaned) 
        #use the following commented code to check cleaned urls 
        # for i in cleanedUrls:
        #     print("URL: ", i)
        #     print('\n')
        
        return(cleanedUrls)
    
    def getText(self, soup):
        paragraphs = soup.find_all('p')
        text = [para.getText() for para in paragraphs] #get text from each paragraph
        text = [t for t in text if len(t) > 30] #filter short unwanted text
        text = " ".join(text) # join it
        
        # print(text)
        return text

    def authenticate_client(self):
        # on a seperate git-ignored file
        ta_credential = AzureKeyCredential(azureKey.key)
        text_analytics_client = TextAnalyticsClient(
            endpoint=azureKey.endpoint, credential=ta_credential)
        return text_analytics_client

    def _getSentiment(self, text):
        r = requests.post(
            "https://api.deepai.org/api/sentiment-analysis",
            data={
                'text': text,
            },
            headers={'api-key': 'quickstart-QUdJIGlzIGNvbWluZy4uLi4K'}
        )
        print(r.json())
        return "veri nice"

    def trimAzure(self, text):
        trimmed = text[0:5000]
        return trimmed

    def _getSentiment(self, client, text):
        documents = [text]
        response = client.analyze_sentiment(documents=documents)[0]
        print("Document Sentiment: {}".format(response.sentiment))
        print("Overall scores: positive={0:.2f}; neutral={1:.2f}; negative={2:.2f} \n".format(
            response.confidence_scores.positive,
            response.confidence_scores.neutral,
            response.confidence_scores.negative,
        ))

        return (response.confidence_scores.positive * -1) + response.confidence_scores.negative

    def _getRating(self, relatedNews, mainReadability, mainReadingTime, mainSentiment):

        counter = 0
        avgReadability = 0
        avgReadingTime = 0
        avgSentiment = 0 
        for elem in relatedNews:
            avgReadability += elem.get("readability")
            avgReadingTime += elem.get("readingTime")
            avgSentiment += elem.get("sentiment")
            counter += 1
        avgReadability = avgReadability/counter
        avgReadingTime = avgReadingTime/counter
        avgSentiment = avgSentiment/counter
        print("avgReadability, ", avgReadability)
        print("avgReadingTime, ", avgReadingTime)
        print("avgSentiment, ", avgSentiment)


        sentimentRating = ((mainSentiment / avgSentiment) - 1)

        readabilityRating = ((mainReadability / avgReadability) - 1) * 5  # sensitive up to 20%
        readabilityRating = np.clip([readabilityRating], -1, 1)[0]

        readingTimeRating = ((mainReadingTime / avgReadingTime) - 1) * 2 # sensitive up to 50%
        readingTimeRating = np.clip([readingTimeRating], -1, 1)[0]

        finalRating = ((sentimentRating + readabilityRating + readingTimeRating + 3) / 6)
        return finalRating


#This main funciton is just for debugging
if __name__ == "__main__":
    a = WebProcessor()
    title = a.getUrlData("https:||www.bbc.com|news|world-us-canada-53129524")
    # print(title)
# "https://www.bbc.com/news/world-us-canada-53129524"
