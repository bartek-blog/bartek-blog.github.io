---
layout: post
comments: true
title:  "How to install python for data science with conda"
date:   2020-06-13 23:00:00 +0200
categories: python conda
---
# How to install python for data science with conda


## Downloading

You can choose right version for your system from
<https://docs.conda.io/en/latest/miniconda.html>. 

__Windows__ users should follow the tutorial from 
<https://docs.conda.io/projects/conda/en/latest/user-guide/install/windows.html>.

__Linux__ users can run the following script:

In terminal execute the following line:

```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh\
    -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
```

__Mac__ users can also run the same script changing  
`Miniconda3-latest-Linux-x86_64.sh` into
`Miniconda3-latest-MacOSX-x86_64.sh`. 

## Adding conda to PATH (Mac and Linux)

Then add `conda` to `$PATH` by running

```
export PATH="$HOME/miniconda/bin:$PATH"
```

If you do not want to run it each time you start the system you can add this line to `~/.bashrc`
(or `.zshrc`). For example by calling

``` shell
nano ~/.bashrc
```

(_Mac_ `.zshrc`) and adding these lines at the end of the file. Then run 

``` shell
source ~/.bashrc
```

## Update conda (all platforms)

``` shell
conda init
conda update conda
```

## Creating and activating environment 


```
conda create -n conda3.7 python=3.7
source activate conda3.7
```

You can deactivate it with `source deactive`. More info on <https://conda.io/docs/user-guide/tasks/manage-environments.html>

## Installing python (with numpy, jupyter and matplotlib)

```
conda install numpy jupyter
conda install -c conda-forge matplotlib 
```

## Install other useful packages

``` shell
conda install pandas scikit-learn plotly
conda install -c conda-forge opencv seaborn
```

## Run jupyter and test it

After activating environment run

```
jupyter notebook
```

When the web page opens, click on button "New", choose "Python 3".

![jupyter](/assets/jupyter_imgs/image2018-11-16_10-14-59.png)

Then copy the following into the cell and press Control+Enter. 



```python
import numpy as np
import matplotlib.pyplot as plt
import matplotlib
from sklearn import datasets, linear_model
%matplotlib inline

diabetes = datasets.load_diabetes()

X = diabetes.data[:, [2]]
y = diabetes.target

from sklearn.linear_model import LinearRegression
reg = LinearRegression()
reg.fit(X, y)
```

_Updated: 2020-06-14_
