from fastapi import FastAPI
import webhandler

api = FastAPI()
webprocessing = webhandler.WebProcessor()

@api.get("/ping/{url}")
async def pong(url: str):
    data = webprocessing.getUrlData(url)
    if data.get("error") != "none":
        return {"Bad inputs" : data.get("error")}
    return {"Headline": data.get("headline")}
