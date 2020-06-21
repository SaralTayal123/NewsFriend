from fastapi import FastAPI
from mlModels import Predictor
import webhandler

api = FastAPI()
webprocessing = webhandler.WebProcessor()
predictor = Predictor()

@api.get("/ping/{url}")
async def pong(url: str):
    data = webprocessing.getUrlData(url)
    if data.get("error") != "none":
        return {"Bad inputs" : data.get("error")}
    return {"Headline": data.get("headline"), "Headline2": data.get("relatedHeadlines")}



#uvicorn API:api --reload
