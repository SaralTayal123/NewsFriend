# NewsFriend (work in progress)

A do-it-all News Helper widget to tell you all you need to know about a news link

# Features
-> Credibility of news source (running an RNN on the top 50 google searches via a Siamese network)  
-> Trigger-ibility analysis (Sentiment analysis of news article and comparing it to the sentiment analysis performed on other news sources to see if this article is trying to generate turmoil)  
-> Clickbait title score (stright forward many-to-one RNN trained on a Clickbait/FakeNews dataset)(low priority)  
-> Summary (get a summary of the article without opening and reading it. Use an encoder/decoder RNN architecture built on LSTMs and attention vectors)  

# Packaging
-> Probably gonna run it as a chrome extension (built on JS)  
-> Have a server perform a lot of computations  
-> Training done via TF2 (Keras) on python. Transfer weights/parameters to JS to run on client browser or run on a server (TBD)  
