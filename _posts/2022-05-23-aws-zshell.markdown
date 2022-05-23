---
layout: post
comments: true
title:  "Using AWS CLI with zshell"
date:   2022-05-23 23:00:00 +0200
categories: [aws]
---

It is very short and based on <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws>

## Installing

It is easy like in `.zshrc` adding 

``` shell
plugins=(
    ...
    aws
)
```
in plugins section.

## Configuring roles accesible through SSO

First, make sure that you have version 2 of awscli instaled
(see <https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>).

Next call:
```shell
aws configure sso
```
and put your url to SSO and region. You should also choose a convinent name.
Here we assume that it is `AdminAccount`

( see <https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html>)

## POWERLEVEL9K prompt


Just add `aws` to `POWERLEVEL9K_LEFT_PROMPT_ELEMENTS`:
```shell
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(... aws)
```

## Assuming role

```shell
asp AdminAccount
```
`AdminAccount` is the name of the role.

_Updated: 2022-05-23_
