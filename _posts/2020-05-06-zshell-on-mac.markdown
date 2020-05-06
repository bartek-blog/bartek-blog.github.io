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

In `~/.zshrc` add you need to copy your initialization code from `~/.zshrc.pre-oh-my-zsh`

``` shell
plugins=(
  git
  bundler
)
```

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



_Updated: 2020-05-06_


    
