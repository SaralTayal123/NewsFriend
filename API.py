from fastapi import FastAPI
from mlModels import Predictor
import webhandler
from textPredictors import TextPredicor

api = FastAPI()
webprocessing = webhandler.WebProcessor()
predictor = Predictor()
textPredictor = TextPredicor()

@api.get("/ping/{url}")
async def pong(url: str):
    data = webprocessing.getUrlData(url)
    if data.get("error") != "none":
        return {"Bad inputs" : data.get("error")}
    
    mainHeadlineScore = textPredictor.getTextResults(data.get("maintext"))
    
    relatedNews = data.get("relatedNews")
    relatedScores = []
    counter = 0
    scoreTally = 0
    for news in relatedNews:
        readingScore = textPredictor.getTextResults(news.get("text"))
        relatedScores.append((news.get("headline"), readingScore))
        scoreTally += readingScore.get("readability")
        counter += 1
    avgReadability = scoreTally/counter
    relativeScore = ((mainHeadlineScore.get("readability")/avgReadability) -1) * 100

    return {
        "Headline": data.get("headline"), 
        "readingscore": mainHeadlineScore,
        "relativeScore": relativeScore,
        "relatedScores": relatedScores
        }
    # return {"Headline": data.get("headline"), "Headline2": data.get("relatedHeadlines")}



#uvicorn API:api --reload
