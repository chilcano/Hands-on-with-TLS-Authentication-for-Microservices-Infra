#!/usr/bin/env bash

sudo apt-get -yqq update -y
sudo apt-get -yqq install -y language-pack-en

echo "--> Installing Tools" 
sudo apt-get -yqq install -y default-jdk maven libssl-dev openssl git awscli curl jq unzip tree
sudo apt-get install -y debian-keyring debian-archive-keyring apt-get-transport-https

echo "--> Cloning the repo"
#sudo mkdir /home/${username}/workdir
#cd /home/${username}/workdir
#git clone https://github.com/chilcano/mtls-apps-examples 
#sudo git clone ${gitrepo}
## important - make sure the owner is playground
#sudo chown -R ${username} /home/${username}/workdir
