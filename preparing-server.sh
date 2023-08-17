#!/bin/bash
exec > /dev/null 2>&1
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
cd $HOME
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
rm -rf go1.20.4.linux-amd64.tar.gz
exec > /dev/tty 2>&1
source $HOME/.bash_profile
