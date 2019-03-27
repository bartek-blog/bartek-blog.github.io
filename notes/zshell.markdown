## zshell

### Ubuntu

Install `zshell`

``` shell
sudo apt install zsh
```

Then you should set it as default by
``` shell
chsh -s $(which zsh)
```

You should see in `/etc/passwd` that the last entrance in the line corresponing 
to your user has changed to `/usr/bin/zsh`. It means that you should see something like:
``` shell
bartek:x:1000:1000:bartek,,,:/home/bartek:/usr/bin/zsh
```

## Oh-my-zsh 

``` shell
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
```

## Powerlevel9k

<https://github.com/bhilburn/powerlevel9k>

``` shell
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

The in your `~/.zshrc` change or add line:
``` shell
ZSH_THEME="powerlevel9k/powerlevel9k"
```

## Nerd-fonts
<https://github.com/ryanoasis/nerd-fonts>

``` shell
git clone https://github.com/ryanoasis/nerd-fonts.git
```
This can take some time.

``` shell
cd nerd-fonts
./install.sh
```
Change fonts in preference -> profiles and add

``` shell
POWERLEVEL9K_MODE='nerdfont-complete'
```
to `.zshrc.`
