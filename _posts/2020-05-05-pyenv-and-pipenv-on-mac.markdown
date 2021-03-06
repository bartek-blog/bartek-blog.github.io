---
layout: post
comments: true
title:  "Pyenv and pipenv on mac"
date:   2020-05-05 12:00:00 +0200
categories: python
tags: python pyenv pipenv mac ohmyzsh
---

## Install pyenv

<https://github.com/pyenv/pyenv>

``` shell
brew install pyenv
```

Then in `~/.zshrc` add

``` shell
eval "$(pyenv init -)"
```

Run

``` shell
source ~/.zshrc
```

and then

``` shell
pyenv install 3.7.7
```

Finally in `~/.zshrc` add:

``` shell
pyenv global 3.7.7
```

### Installation of pyenv-virtualenvwrapper

<https://github.com/pyenv/pyenv-virtualenvwrapper>

``` shell
brew install pyenv-virtualenvwrapper
```

To `~/.zshrc` add

``` shell
pyenv virtualenvwrapper
```
after `eval "$(pyenv init -)"`


## Install pipenv

``` shell
brew install pipenv
```

Then, inside a project, you can start using `pipenv` with

``` shell
pipenv install
```

and use it with

``` shell
pipenv shell
```

It will create virtualenv if does not exists specific for a project.

## ohmyzsh

If you use Oh My Zsh you can add plugin by

``` shell
plugins=(... pipenv virtualenv ...)
```

_Updated: 2020-05-06_
