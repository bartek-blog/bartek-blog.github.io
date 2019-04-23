## Create EC2

From <https://lucacerone.net/2018/install-and-configure-jupyterhub-in-an-amazon-ec2-instance/>

Choose `Ubuntu 18.04`


Add security group



save `jupyterhub.pem` to `~/.ssh/`

press <Connect>

``` shell
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get autoremove
sudo apt-get autoclean
sudo reboot now
```

Update to latest Ubuntu:

``` shell
tmux
sudo do-release-upgrade
```


``` shell
jupyter notebook --generate-config
emacs ~/.jupyter/jupyter_notebook_config.py
```

<https://www.guru99.com/apache.html>
