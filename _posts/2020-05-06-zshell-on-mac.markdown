---
layout: post
comments: true
title:  "Zshell on mac"
date:   2020-05-06 12:00:00 +0200
categories: zshell
tags: zshell
---

## zshell

Nowdays mac os comes with `zshell` as default shell. You can check it with

``` shell
echo $0
```

## iterm 2

<https://www.iterm2.com/>

``` shell
brew cask install iterm2
```

### Color schemas

You can download color schema from <https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/schemes>

## Oh My Zsh
<https://github.com/ohmyzsh/ohmyzsh>

``` shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

You may need to run

``` shell
compaudit | xargs chmod g-w,o-w
```

In `~/.zshrc` you may need to copy your initialization code from `~/.zshrc.pre-oh-my-zsh`.

### Autosuggestion

``` shell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Add plugins

In `~/.zshrc` add the following

``` shell
plugins=(
  git
  bundler
  kubectl
  pipenv
  docker
  docker-compose
  virtualenv
  zsh-autosuggestions
  z
)
```

### Git

* gc - git commit
* gst - git status
* gp – git push

## Powerline

## Powerline fonts

<https://github.com/powerline/fonts>

``` shell
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
```

We need to set both the Regular font and the Non-ASCII Font in "iTerm > Preferences > Profiles >
Text" to use a patched font

## Theme

In `~/.zshrc` add

``` shell
ZSH_THEME="agnoster"
```

## powerlevel9k

<https://github.com/Powerlevel9k/powerlevel9k>

``` shell
brew tap sambadevi/powerlevel9k
brew install powerlevel9k
```

In `~/.zshrc` add the following

``` shell
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme
```

Alternatively you can: 

``` shell
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

### Nerd fonts

<https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts>

``` shell
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
```

Then change theme in `~/.zshrc` by

``` shell
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel9k/powerlevel9k"
```

### prompt

Agian inn `~/.zshrc` :

``` shell
POWERLEVEL9K_VIRTUALENV_BACKGROUND=107
POWERLEVEL9K_VIRTUALENV_FOREGROUND='white'
POWERLEVEL9K_PYENV_BACKGROUND=110
POWERLEVEL9K_PYENV_FOREGROUND='white'

POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv pyenv dir newline os_icon vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time ram battery)
```

_Updated: 2020-05-06_


    
