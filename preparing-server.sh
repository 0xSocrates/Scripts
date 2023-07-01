#!/bin/bash
exec > /dev/null 2>&1
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
exec > /dev/tty 2>&1
sleep 1
