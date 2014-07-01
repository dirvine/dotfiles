#!/bin/bash

cd ..
git submodule foreach "git pull"
cd -
git pull
