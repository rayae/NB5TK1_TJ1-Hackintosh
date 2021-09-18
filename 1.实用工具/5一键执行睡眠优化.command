#!/bin/bash

sudo pmset -a hibernatemode 0
sudo rm -rf /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
sudo pmset -a proximitywake 0
