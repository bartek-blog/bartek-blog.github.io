---
layout: post
comments: true
title:  "Introduction to JAGS"
date:   2020-12-03 23:00:00 +0200
categories: [jags, R]
---
# Introduction to JAGS

From <http://mcmc-jags.sourceforge.net/> "JAGS is Just Another Gibbs Sampler. It is a program for analysis of Bayesian
hierarchical models using Markov Chain Monte Carlo (MCMC) simulation...""

## Installation

``` shell
brew install jags
```

Then for `R` you need first in `~/.R/Makevars` set correct `CC` and `CXX` fo JAGS:

``` shell
CC=clang
CXX=clang++
```

Then start `R` session and install `rjags`:
``` shell
install.packages("rjags")
```


## Usage

### Load package

``` R
library('rjags')
```

### Specify model

``` R
model.str = "model {
    for (i in 1:n) {
        y[i] ~ dnorm(mu, 1.0/sigma2)
    }
    mu ~ dt(0.0, 1.0/1.0, 1)
    sigma2 = 1.0
}"
```

### Set up the model

``` R
y <- c(1.2, 1.4, -0.5, 0.3, 0.9, 2.3, 1.0, 0.1, 1.3, 1.9)
n <- length(y)

data.jags <- list(y=y, n=n)
params <- c("mu")

inits <- function() {
  inits <- list("mu"=0.0)
}

model <- jags.model(textConnection(model.str), data=data.jags, init=inits)
```

## Run sampler

```{r}
update(model, 500)

model.simulation  = coda.samples(model=model, variable.names=params, n.iter=1000)
```

## Post processing

```{r}
library("coda")

plot(model.simulation)
```

_Updated: 2020-12-03_
