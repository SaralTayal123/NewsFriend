import requests
from bs4 import BeautifulSoup

class WebProcessor:
    def getUrlData(self, urlString):
        url = self._cleanUrl(urlString)
        page = requests.get(url)
        if page.status_code != 200:
            return ({"error": page.status_code})
        self.soup = BeautifulSoup(page.content,'html.parser')
        headline = self._getHeadline()
        return {"headline": headline,
                "score1": 1, #to be filled in later
                "score2": 2, #to be filled in later
                "error": "none",
        }
    def _cleanUrl(self, dirtyUrl):
        urlClean = dirtyUrl.replace("|" ,"/")
        return urlClean

    def _getHeadline(self):
        headline = self.soup.find_all('h1')
        # print(headline[0].text)
        self.headline = headline[0].text
        return self.headline

        # print(self.soup.prettify())

if __name__ == "__main__":
    a = WebProcessor()
    title = a.getUrlData("https:||www.bbc.com|news|live|world-53126072")
    print(title)