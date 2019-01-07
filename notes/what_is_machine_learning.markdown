_Machine Learning_ is a term widely used when referred to a process of writing programs which are
able to 'learn' their parameters from given data. We would like the program "learn" those parameters
in order to be able to predict certain values for data that we have not observed before. For
example, in order to predict future sales of a new phone in order to provide enough of them to a
store. Or recommend a new book that could be interesting for a on-line store client. Or detect a
disease of a patient.

In classical science we are observing reality and we are trying to find rules or formulas that model
it. For example, you may try to observe an object that moves with constant speed. By comparing
different distances $S$ and times $t$ you should get to a conclusion that $S = C \cdot t$, where $C$
is some constant (which is of course a speed). This formula allows you to tell how much time it
takes for an object to move on distances that you have not seen before.

In machine learning we so something similar. We start with a formula, often with many unknown
parameters. Then we use data to train/fit those parameters to given data and then on new data we
test how well we have done it. The main difference is that we do not care that much about how the
formula looks like as long it produced results that are good enough. Very often we are able to
accept that the results are far from being perfect as with this formula our main goals are getting
closer. For example, as long our book recommendation increases sales, we do not need to worry if
they are not very accurate. In fact, it could happen that some less accurate recommendations could
produce better sales in a long term.

In general distinguish three types of Machine Learning algorithms:
1. Supervised learning algorithms: those are used when we use labeled data to build models.
2. Unsupervised learning algorithms: those are used when we want to find a new features in data that
   we are not aware of like, for examples, clusters.
3. Reinforcement learning algorithms: those are agent that take action in an environment. Their
   objective is to maximize rewards. Classical example is an agent playing a game with a human.
   
