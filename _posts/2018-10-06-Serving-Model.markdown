---
layout: post
comments: true
title:  "Serving Model"
date:   2018-10-06 00:00:00 +0200
categories: python ml aiohttp sklearn nlp
---


# How to serve a model

Here we show how to:
1. train a model
2. save it to pickle
3. load a model and serve it with `aiohttp`.

In order to keep it simple we are going to use a `sklearn` model.

## Getting data

Dataset `train.csv` comes from kaggle: https://www.kaggle.com/c/jigsaw-toxic-comment-classification-challenge. We locally store in `data` directory.


```python
import pandas as pd

comments_df = pd.read_csv("data/toxic-comment-classification-challenge/train.csv")
comments_df.head(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>comment_text</th>
      <th>toxic</th>
      <th>severe_toxic</th>
      <th>obscene</th>
      <th>threat</th>
      <th>insult</th>
      <th>identity_hate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0000997932d777bf</td>
      <td>Explanation\nWhy the edits made under my usern...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>000103f0d9cfb60f</td>
      <td>D'aww! He matches this background colour I'm s...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



## Predict if comment is toxic

### Train - validation split


```python
from sklearn.model_selection import train_test_split

X_train, X_val, y_train, y_val = \
    train_test_split(comments_df[['comment_text']], comments_df['toxic'], random_state=10)
X_train.head(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>comment_text</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>34852</th>
      <td>This is a straw man argument, Mr Merkey.  Nobo...</td>
    </tr>
    <tr>
      <th>17133</th>
      <td>ARC Gritt, the fucking cunt of all cunts, ruin...</td>
    </tr>
  </tbody>
</table>
</div>



### Preprocessing and vectorizer

Let's do some simple preprocessing.


```python
import re

import nltk
from nltk.stem import SnowballStemmer

REPLACE_BY_SPACE_RE = re.compile('[/(){}\[\]\|@,;]')
GOOD_SYMBOLS = "€\?"
GOOD_SYMBOLS_RE = re.compile('([' + GOOD_SYMBOLS + '])')
BAD_SYMBOLS_RE = re.compile('[^0-9a-z '+ GOOD_SYMBOLS + ']')
ADD_SPACES_SYMBOLS_RE = re.compile("([\?])")
STEMMER = SnowballStemmer('english')

class TextPreprocessor:
        
    def transfrom_text(self, text):
        text = re.sub(GOOD_SYMBOLS_RE, r"\1", text) #process good symbols
        text = text.lower()
        text = re.sub(REPLACE_BY_SPACE_RE, " ", text) # process bad symbols
        text = re.sub(BAD_SYMBOLS_RE, "", text) # process bad symbols
        text = re.sub(ADD_SPACES_SYMBOLS_RE, r" \1 ", text)
        test = " ".join([STEMMER.stem(word) for word in text.split()])
        return text
    
    def transform(self, series):
        return series.apply(lambda text: self.transfrom_text(text))
```


```python
from sklearn.feature_extraction.text import TfidfVectorizer

class Vectorizer:

    def __init__(self):
        self.vectorizer = TfidfVectorizer(min_df=4, max_df=0.9, ngram_range=(1, 2), token_pattern='(\S+)')
        self.pickle_fn = "pickles/messaging_vectorizer.pickle"
        
    def fit(self, column):
        self.vectorizer.fit(column)
        
    def transform(self, column):
        return self.vectorizer.transform(column)
    
    def dumps(self):
        with open(self.pickle_fn, 'wb') as f:
            pickle.dump(self.vectorizer, f, pickle.HIGHEST_PROTOCOL)
        
    def load(self):
        with open(self.pickle_fn, 'rb') as f:
            self.vectorizer = pickle.load(f)
```

### Model


```python
import pickle
from sklearn.linear_model import LogisticRegression
    
class Model:
    
    def __init__(self):
        self.model = LogisticRegression(class_weight='balanced')
        self.pickle_fn = "pickles/messaging_model.pickle"
        
    def fit(self, X, y):
        self.model.fit(X, y)
        
    def predict(self, X):
        return self.model.predict(X)

    def dumps(self):
        with open(self.pickle_fn, 'wb') as f:
            pickle.dump(self.model, f, pickle.HIGHEST_PROTOCOL)
        
    def load(self):
        with open(self.pickle_fn, 'rb') as f:
            self.model = pickle.load(f)
```


```python
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score,\
    average_precision_score, roc_auc_score, recall_score

def scores(y, predicted):
    return {
        'accuracy': accuracy_score(y, predicted),
        'precision': precision_score(y, predicted),
        'recall': recall_score(y, predicted),
        'f1-score': f1_score(y, predicted),
        "roc_auc": roc_auc_score(y, predicted),
        'average-Precision': average_precision_score(y, predicted)}
```

### Puting preprocessor, vectorizer and model together


```python
class TfidfModelAll:
    
    def __init__(self, colname="text"):
        self.colname = colname
        self.preprocessor = TextPreprocessor()
        self.vectorizer = Vectorizer()
        self.model = Model()
           
    def fit_predict(self, X, y):
        print("preprocessor...")
        X_fe = pd.DataFrame({self.colname: self.preprocessor.transform(X[self.colname])})
        print("vectorizer...")
        self.vectorizer.fit(X_fe[self.colname])
        print("model...")
        X_fe = self.vectorizer.transform(X[self.colname])
        self.model.fit(X_fe, y)
        return self.model.predict(X_fe)
        
    def predict(self, X=None, message=None):
        if message is not None:
            X = pd.DataFrame({self.colname: [message]})
        X_fe = pd.DataFrame({self.colname: self.preprocessor.transform(X[self.colname])})        
        X_fe = self.vectorizer.transform(X_fe[self.colname])
        return self.model.predict(X_fe)
    
    def predict_message(self, message):
        return self.predict(message=message)[0]
        
    def dumps(self):
        self.vectorizer.dumps()
        self.model.dumps()
    
    def load(self):
        self.vectorizer.load()
        self.model.load()
```

### Train, validate it and save the model to a pickle


```python
tfidf_model = TfidfModelAll("comment_text")
y_train_hat = tfidf_model.fit_predict(X_train, y_train)
scores(y_train, y_train_hat)
```

    preprocessor...
    vectorizer...
    model...





    {'accuracy': 0.953358177777035,
     'average-Precision': 0.6641958777165086,
     'f1-score': 0.8007424858999072,
     'precision': 0.6819066147859922,
     'recall': 0.969738889849559,
     'roc_auc': 0.96067231602142}




```python
y_val_hat = tfidf_model.predict(X_val)
scores(y_val, y_val_hat)
```




    {'accuracy': 0.9331963001027749,
     'average-Precision': 0.5239641176536308,
     'f1-score': 0.7035265324285237,
     'precision': 0.6010264208325413,
     'recall': 0.848175965665236,
     'roc_auc': 0.8950682123362819}




```python
tfidf_model.dumps()
```

## Serving model

### Load model


```python
tfidf_model2 = TfidfModelAll("comment_text")
tfidf_model2.load()
```


```python
y_val_hat = tfidf_model2.predict(X_val)
scores(y_val, y_val_hat)
```




    {'accuracy': 0.9331963001027749,
     'average-Precision': 0.5239641176536308,
     'f1-score': 0.7035265324285237,
     'precision': 0.6010264208325413,
     'recall': 0.848175965665236,
     'roc_auc': 0.8950682123362819}




```python
message = """All of my edits are good. 
Cunts like you who revert good edits because you're too stupid to understand how to write well , 
and then revert other edits just because you've decided to bear a playground grudge, are the problem.  
Maybe one day you'll realise the damage you did to a noble project.  201.215.187.159"""
tfidf_model2.predict_message(message=message)
```




    1



### Serve the model


```python
import asyncio
asyncio.get_event_loop().close()
print(asyncio.get_event_loop().is_closed())
loop = asyncio.new_event_loop()
asyncio.set_event_loop(asyncio.new_event_loop())
```

    True



```python
from aiohttp import web

async def handler(request):
    data = await request.post()
    message = data.get("message") 
    prediction = tfidf_model2.predict_message(message=message)
    return web.Response(text=str(prediction))

app = web.Application()

app.add_routes([web.post('/toxic', handler)])
web.run_app(app)
```

    ======== Running on http://0.0.0.0:8080 ========
    (Press CTRL+C to quit)


### Check how it work

From command line execute the following:
```
curl -X POST http://0.0.0.0:8080/toxic -d "message=All of my edits are good.                               
Cunts like you who revert good edits because you're too stupid to understand how to write well ,
and then revert other edits just because you've decided to bear a playground grudge, are the problem.
Maybe one day you'll realise the damage you did to a noble project.  201.215.187.159"
```


## Thanks

I would like to thank Luca Cerone (<http://www.lucacerone.net/>) for helpfull conversation and suggesting usage of `aiohttp` instead of `flask`.
