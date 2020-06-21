import tensorflow.keras
from tensorflow.keras.models import model_from_json

#INCOMPLETE: THIS FILE WILL LOAD MY TF TRAINED MODELS FOR PREDICITON

class Predictor:
    def __init__(self):
        return  #temp till i finish implementing
        # load jsonweights and create model
        json_file = open('model.json', 'r')#dummy filenames
        loaded_model_json = json_file.read()
        json_file.close()
        self.loaded_model = model_from_json(loaded_model_json)
        self.loaded_model.load_weights("modelweights.h5") #dummy filenames
    def predict(self, headline, headlineType):
        return  # temp till i finish implementing
        headlineProcessed = _preprocess(headline)
        sentimentPrediction = self.loaded_model(headlineProcessed)

        if headlineType == "main":
            toReturn = {
                "Sentiment": sentimentPrediction,
                "FakeNews": 2,
                "Sarcasm": 1,
                "Readability": 4, #complexity of words
                "Time": 1, #how long the news will take to read
            }
        else: 
            toReturn = {
                "Sentiment": sentimentPrediction,
            }
        return 

    #this method allows me to preprocess data
    def _preprocess(self):
        return #temp till i finish implementing#temp till i finish implementing
