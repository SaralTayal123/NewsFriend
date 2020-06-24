# NewsFriend (work in progress)

A do-it-all News Helper widget to tell you all you need to know about a news link

# Features
-> Credibility of news source (running an RNN on the top 50 google searches via a Siamese network) <br>
-> Readability score (how easy is the language to read)<br>
-> Reading time (how long will it take you to read the article)<br>
-> Trigger-ibility analysis (Sentiment analysis of news article and comparing it to the sentiment analysis performed on other news sources to see if this article is trying to generate turmoil)  <br>
-> Clickbait title score (stright forward many-to-one RNN trained on a Clickbait/FakeNews dataset)(low priority)  <br>
-> Summary (get a summary of the article without opening and reading it. Use an encoder/decoder RNN architecture built on LSTMs and attention vectors)(reach goal)<br>
-> comparison of all of the above metrics against the top 10 most similar articles to offer you alternate choices of news on the same topic <br>
-> reccomendation for 5 other articles that are easier to read/shorter/offer more neutral emotions (customizable filters)<br>
-> caching (long term goal to prevent recomputing these features for the same article) (Use a database...)<br>
-> Dope dashboard!!!<br>

# Packaging
-> Run as a chrome extension and as a flutter app (chrome extension will let you right click on links)<br>
-> Have a server perform a lot of computations and offer results as an API (Using FastAPI right now). Looking at deploying on Heroku <br>
-> Training done via TF2 (Keras) on python. Transfer weights/parameters to API service <br>
