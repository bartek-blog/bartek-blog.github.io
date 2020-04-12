---
layout: post
comments: true
title:  "Python packages"
date:   2020-04-02 12:00:00 +0200
categories: python 
tags: packages
---

Here we present how one can organize python project as a package. 
We will create sample package `sample-package`. 

There is a great guide to packages, namely 
[The Hitchhiker’s Guide to Packaging](https://the-hitchhikers-guide-to-packaging.readthedocs.io/en/latest/index.html).  We
recommend start form there. Here we are definitely build on it, but we do few significant changes.

Our package will generate random number.

## Directory organization

We will do a bit not standard, however very popular, package organization. It makes `setup.py` a bit
more complicated, but still perfectly functional. We also move all requirements need to
`requirements.txt` and `requirements.test.txt` files. This makes the code for development more
DRY. 

The structure of package is the following:

``` yaml
samplePackage/
    Makefile
    README.md
    requirements.txt
    requirements.test.txt
    setup.py
    setup.cfg
    src/
        samplePackage/
            __init__.py
            normal_number_generator.py
    tests/
        
```

## Setup file

Let's create `setup.py` file first.

``` python
import os
import sys

from setuptools import setup, find_packages

base_dir = os.path.dirname(__file__)
src_dir = os.path.join(base_dir, 'src')
sys.path.insert(0, src_dir)

import samplePackage

def get_requirements(requirements_path='requirements.txt'):
    with open(requirements_path) as fp:
        return [x.strip() for x in fp.read().split('\n') if not x.startswith('#')]


setup(
    name='samplePackage',
    version=samplePackage.__version__,
    description='Sample Python Package',
    author='bartek',
    author_email='bartekskorulski@gmail.com',
    packages=find_packages(where='src', exclude=['tests']),
    package_dir={'': 'src'},
    install_requires=get_requirements(),
    setup_requires=['pytest-runner', 'wheel'],
    testsp_require=get_requirements('requirements.test.txt'),
    url='https://github.com/sbartek/sample-package',
    classifiers=[
        'Programming Language :: Python :: 3.7.7'
    ],
)
```

Next, let's make this setup work. So create directory `src` and inside of it `samplePackage`. Then,
inside it file `__init__.py` with

``` python
__version__ = '0.0.1'
```

Then create `requirements.txt` with:

``` python
numpy==1.18.2
```

and `requirements.test.txt` with

``` python
pytest==5.4.1
pytest-cov==2.8.1
flake8==3.7.9
```

Now you should be able to run the following:

``` shell
pip install -e .
python -c "import samplePackage"
```

and you should not see any error. 

Note that we have install package in editable mode.

## Tests

Create directory `tests/` and inside file `test_simple_package.py` with the following:


``` python
from unittest import TestCase
from samplePackage.normal_number_generator import NormalNumberGenerator

class TestNormalNumberGenerator(TestCase):

    def setUp(self):
        seed = 42
        self.normal_number_generator = NormalNumberGenerator(seed=seed)

    def test_generate(self):
        self.assertAlmostEqual(self.normal_number_generator.generate(), 0, places=4)
```

Let's install test requirements by

``` shell
pip install -r requirements.test.txt
```

Now run tests:

``` python
pytest
```

Of course test should fail since we still did not implemented `normal_number_generator`.
So let's do it now. 

## The module

Inside `src/samplePackage/` create `normal_number_generator.py` file with the following code.

``` python
import numpy as np


class NormalNumberGenerator:

    def __init__(self, seed=None):
        if seed is not None:
            np.random.seed(seed=seed)

    def generate(self):
        return np.random.normal()
```

Now when you run test you should have an error like:

``` shell
E       AssertionError: 0.4967141530112327 != 0 within 4 places (0.4967141530112327 difference)
```

Copy then first 4 digits `0.4967` into `tests/test_simple_package.py` by changig the assert into:

``` python
        self.assertAlmostEqual(self.normal_number_generator.generate(), 0.4967, places=4)
```

## flake8

[`flake8`](https://flake8.pycqa.org/en/latest/index.html) is a tool for enforcing style consistency
across Python projects. You can run it by:

``` python
flake8
```

You should see some errors. In particular, it tells that lines are too long. We would rather allow
to have lines a bit longer (100 characters). For this we create file `setup.cfg` with the following:

``` python
[flake8]
exclude =
        setup.py,
        .eggs/
max-line-length = 100
```

If there are more errors please remove them.

## Coverage

You can also get report about coverage of your tests. You can get them by running:

``` shell
pytest --cov=samplePackage tests/
```

## Makefile

You can automatize some task by using `Makefile`. Create it with the following content:

``` shell
PIP := pip3

.PHONY: help
help: ## display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: init
init: ## install package
	${PIP} install -r requirements.txt
	${PIP} install -r requirements.test.txt
	${PIP} install .

.PHONY: python_tests
python_tests: ## run unit tests
	pytest --cov=samplePackage tests/
	flake8 
```

Now you can run test by:

``` shell
make python_tests
```

Moreover, when you download and need to install package you can do this by:

``` shell
make init
```

Do not forget to add `README.md` with instructions how to install the package.

## Code

Code is available at <https://github.com/sbartek/sample-package>

_Updated: 2020-04-12_
