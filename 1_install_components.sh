#!/bin/bash

# Disable ubuntu "need restart" promt
sudo apt -y remove needrestart

# install containerlab
curl -sL https://containerlab.dev/setup | sudo -E bash -s "all"

# install python pip
sudo apt install python3-pip -y

# install Ansible 8.5.0
python3 -m pip install ansible==8.5.0 --user


#ansible path
export PATH="$HOME"/.local/bin:${PATH:+:${PATH}}


