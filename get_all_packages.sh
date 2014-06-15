#!/bin/bash
dpkg --get-selections > ~/Package.list
sudo cp -R /etc/apt/sources.list* ~/etc/apt/
sudo apt-key exportall > ~/Repo.keys
