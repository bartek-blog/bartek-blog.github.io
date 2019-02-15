---
layout: post
comments: true
title:  "Machine Learning Part 1: What Is Machine Learing?"
date:   2019-02-13 18:00:00 +0200
categories: ml introduction
---

In this short note we try to explain what is Machine Learning and what are the most important types
of it.

## What machine learning

_Machine Learning_ is a term widely used when referred to a process of writing programs which are
able to 'learn' their parameters from given data. We would like the program to "learn" those
parameters in order to be able to predict certain values for data that we have not observed
before. For example, we do it to predict future sales of a new phones in order to provide enough of
them to a store. Or recommend a new book that could be interesting for a client of an on-line
store. Or detect a disease of a patient.

In classical science we are observing reality and we are trying to find rules or formulas that model
it. For example, you may try to observe an object that moves with constant speed. By comparing
different distances $S$ and times $t$ you should get to a conclusion that 

$$S = C \cdot t$$, 

where $C$ is some constant (which is of course the speed). This formula allows you to tell how much
time it takes for an object to move on distances that you have not seen before.

In machine learning we do something similar. We start with a formula, often with many unknown
parameters. Then we fit those parameters to given data and then on new data we test how well we have
done it. This process is called training. The main difference with classical science is that we do
not care that much about how the formula looks like as long it produced results that are good
enough. Very often we are able to accept that the results are far from being perfect as with this
formula our main goals are getting closer. For example, as long our book recommendation increases
sales, we do not need to worry if they are not very accurate. In fact, it could happen that some
less accurate recommendations could produce better sales in a long term.

## Types of Machine Learning

In general distinguish three types of Machine Learning algorithms:
1. Supervised learning algorithms: those are used when we use labeled data to build models.
2. Unsupervised learning algorithms: those are used when we want to find a new features in data that
   we are not aware of like, for examples, clusters.
3. Reinforcement learning algorithms: those are agent that take action in an environment. Their
   objective is to maximize rewards. Classical example is an agent playing a game with a human.

### Supervised learning 

The most popular type of Machine Learning is _supervised learning_. __Supervise__ means that the
process of the training of the model is supervised by providing correct answer. This way the
algorithm responsible for the training knows if it is doing right or wrong and can adjust
accordingly parameters of the model. Shortly, this means that we have data the are labeled. They
should have the format $(X_i, y_i)$ where $X_i$ are the data that are used to predict (often called
__features__) and $y_i$ are data we want to predict (often called __labels__). 


__Example 1__

we would like to predict what is the temperature tomorrow based on today's temperature
and pressure. We have two _features_: temperature and pressure on specific day and the label is the
temperature of the next day.

__Example 2__

we would like to predict if a person is a women or a man based on her/his weight, height and
age. Here we have three features: weight, height and age, and the label is either: `woman` or `man`.

There is a fundamental difference between _Example 1_ and _Example 2_. The first on is an example of
a problem called __regression__ and the second is often called __clasification__.

#### Regressions

When in supervised learning we deal with labels that are continuous we call such a problem
__regression__. There are many examples of regressions. The most classical one is the prediction of
the height of a men based on the height of his father. 

#### Clasification

In supervised learning we deal with classification problem when labels are discrete. For example, we
can predict if a picture contains a person or not. Or we could predict if a picture contains object
of one of the following class: `car`, `plane`, `train` or  `motorbike`. 

### Unsupervised learning

In unsupervised we deal we a problem when we do not have labels. So what we actually want to do? We
could for example build an algorithm that try to cluster data in several classes. Or reduce the
dimension of data in situation when $X_i$ has lots of features. 

### Reinforcement learning 

Reinforcement learning is algorithm of a different type. Its objective is to train a model (here
often called an agent) that will decide what action should be taken based on observations of an
environment (called the __state__ of the __environment__). Each action leads to new observation that
leads to another actions. This algorithm trains the model based on received rewards.

__Example 3__

__AlphaGo__ is an algorithm that has trained an agent that won four out of five games against Lee
Sedol, one of the best world Go player. Here the __environment__ is the Go board. Position of the
pieces on the board is the __state__. The objective of one of a reinforcement algorithm used to
train the model was to win as many games as possible (the __reward__ is 1 if the agent win the game
and -1 if lose).

__Next__ In the second part we will explain what Linear Regression is, how to train this kind of
model and then test its performance.
See [Machine Learning Part 2: How to train linear model and then test its performance]({% post_url 2019-02-15-Train-Test-Model %})
