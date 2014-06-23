#!/bin/bash
apt-clone clone ~/Package.list
sudo cp -R /etc/apt/sources.list* ~/etc/apt/
sudo apt-key exportall > ~/Repo.keys
