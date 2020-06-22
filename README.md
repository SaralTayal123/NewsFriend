# NewsFriend (work in progress)

A do-it-all News Helper widget to tell you all you need to know about a news link

# Features
-> Credibility of news source (running an RNN on the top 50 google searches via a Siamese network)  
-> Readability score (how easy is the language to read)
-> Reading time (how long will it take you to read the article)
-> Trigger-ibility analysis (Sentiment analysis of news article and comparing it to the sentiment analysis performed on other news sources to see if this article is trying to generate turmoil)  
-> Clickbait title score (stright forward many-to-one RNN trained on a Clickbait/FakeNews dataset)(low priority)  
-> Summary (get a summary of the article without opening and reading it. Use an encoder/decoder RNN architecture built on LSTMs and attention vectors)(reach goal)
-> comparison of all of the above metrics against the top 10 most similar articles to offer you alternate choices of news on the same topic
-> reccomendation for 5 other articles that are easier to read/shorter/offer more neutral emotions (customizable filters)
-> caching (long term goal to prevent recomputing these features for the same article) (Use a database...)
-> Dope dashboard!!!

# Packaging
-> Run as a chrome extension and as a flutter app (chrome extension will let you right click on links)
-> Have a server perform a lot of computations and offer results as an API (Using FastAPI right now). Looking at deploying on Heroku 
-> Training done via TF2 (Keras) on python. Transfer weights/parameters to API service
