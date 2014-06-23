#!/bin/bash
sudo apt-key add ~/Repo.keys
sudo cp -R ~/sources.list* /etc/apt/
sudo apt-get update
sudo apt-get install apt-clone
apt-clone restore ~/Package.list
