---
layout: post
comments: true
title:  "Pyenv and VirtualEnvs"
date:   2018-08-18 12:00:00 +0200
categories: python virtualenv
---

Program `pyenv` together with `virtualenvwrapper` is possibly the coolest, most practical and
easiest way of installing and dealing with different versions of python and its
configurations on the same machine.

## Installation of pyenv

### Ubuntu

``` shell
sudo apt install make build-essential zlib1g-dev libffi-dev libssl-dev \
    libbz2-dev libreadline-dev libsqlite3-dev
```

### Mac
``` shell
brew install zlib
```

Then in `~/.bash_profile` or `~/.zshenv` put

``` shell
#For compilers to find zlib you may need to set:
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

#For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
```

## Linux/Mac

``` shell
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
```
If using zshell, you have to change first two `~\.bashrc` for `.zshenv` and the last for `.zshrc`. 

## Pyenv usage

### List available python versions:

``` shell
pyenv install -l
```

### Install python version
``` shell
pyenv install 3.7.0
```

### Setting up global python 

After installing at least one version of python we can set it as global by

``` shell
pyenv global 3.7.0
```

and also can be added as default in `.bashrc` (or `.bash_profile` in mac) or `.zshrc`.

``` shell
echo 'pyenv global 3.7.0' >> ~/.bashrc
```

### List installed python's versions

``` shell
pyenv versions
```

## Installation of pyenv-virtualenvwrapper

<https://github.com/pyenv/pyenv-virtualenvwrapper>

Fist, we need to make sure we have set up a global python (see above).

``` shell
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git\
    $(pyenv root)/plugins/pyenv-virtualenvwrapper
```

Now you should be able to execute:

``` shell
pyenv virtualenvwrapper
```

This will make sure that packages like `virtualenv` are installed on your system.

In order to have access to commands of `virtualenvwrapper` every time we run sell, we could add
this line to `.bashrc` (`.bash_profile`, `.zshrc`) by

``` shell
echo "pyenv global 3.7.0" >> ~/.bashrc
echo "pyenv virtualenvwrapper" >> ~/.bashrc
```

### Update of pyenv-virtualenvwrapper


``` shell
cd $(pyenv root)/plugins/pyenv-virtualenvwrapper
git pull
```

## Working with virtualenvwrapper

Now using `pyenv` we can choose previously installed version of python.

``` shell
pyenv shell 3.7.0
```

Then we can create virtualenv by simply calling:

``` shell
mkvirtualenv py3.7tf
```

This will create a new python's installation in `.virtualenvs` directory.

In order to switch to this version you can call

``` shell
workon py3.7tf
```

Now you can install packages with `pip`, for example:

``` shell
pip install tensorflow
```
This package will be install only for `py3.7tf` environment. You can list installed packages calling 

``` shell
lssitepackages
```

## Deactivating

you can deactivate `virtualenv` by simply calling

``` shell
deactivate
```

## Links

* pyenv: <https://github.com/pyenv/pyenv>
* pyenv-virtualenvwrapper: <https://github.com/pyenv/pyenv-virtualenvwrapper>
* virtualenvwrapper: <https://virtualenvwrapper.readthedocs.io/en/latest/>
* <https://opencafe.readthedocs.io/en/latest/getting_started/pyenv/>

