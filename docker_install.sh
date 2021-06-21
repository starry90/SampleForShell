#!/bin/bash

set -e
set -u

#Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

#Set up the repository
#Update the apt package index and install packages to allow apt to use a repository over HTTPS:
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

#Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint.
sudo apt-key fingerprint 0EBFCD88
#Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below. Learn about nightly and test channels.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

#Install Docker Engine
#1.Update the apt package index, and install the latest version of Docker Engine and containerd, or go to the next step to install a specific version:
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
#2.To install a specific version of Docker Engine, list the available versions in the repo, then select and install:
#a. List the versions available in your repo:
apt-cache madison docker-ce
#b. Install a specific version using the version string from the second column, for example, 5:18.09.1~3-0~ubuntu-xenial.
sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
#3.Verify that Docker Engine is installed correctly by running the hello-world image.
sudo docker run hello-world

exit
