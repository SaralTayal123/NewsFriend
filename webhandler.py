import requests
from bs4 import BeautifulSoup

# the reason I'm using  '|' in my urls instead of '/' is because i want to pass
# my url within the api request url... That's why i need to do preprocessing
# The chrome extension will convert the url to use '|' before an API call

class WebProcessor:
    def getUrlData(self, urlString):
        url = self._cleanUrl(urlString)
        mainHeadline = self._getHeadline(url, getError = True)
        # if isinstance(mainHeadline, dict):
        #     #already formatted to have the error dictionary
        #     return mainHeadline 

        #get other relevant news articles
        releventNewsUrls = self._google(mainHeadline)

        #TODO: add a way to remove the duplicate url
        ##############################################
        headlines = []
        for url in releventNewsUrls:
            headlines.append(self._getHeadline("https://"+url))
        ####
        for i in headlines:
            print("Headline: ", i)
            print('\n')
        ####
        return {"headline": mainHeadline,
                "score1": 1, #to be filled in later
                "score2": 2, #to be filled in later
                "error": "none",
        }
    def _cleanUrl(self, dirtyUrl):
        urlClean = dirtyUrl.replace("|" ,"/")
        return urlClean

    def _getHeadline(self, url, getError = False):
        page = requests.get(url)
        if page.status_code != 200:
            return ({"error": page.status_code})
        self.soup = BeautifulSoup(page.content,'html.parser')
        headline = self.soup.find_all('h1')
        self.headline = headline[0].text
        return self.headline

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
            cleaned = cleaned.partition("&")[0]

            #filter out some random empty urls i was getting
            if len(cleaned) > 10: 
                cleanedUrls.append(cleaned) 
        #use the following commented code to check cleaned urls 
        for i in cleanedUrls:
            print("URL: ", i)
            print('\n')
        return(cleanedUrls)

#This main funciton is just for debugging
if __name__ == "__main__":
    a = WebProcessor()
    title = a.getUrlData("https:||www.bbc.com|news|live|world-53126072")
    # print(title)
