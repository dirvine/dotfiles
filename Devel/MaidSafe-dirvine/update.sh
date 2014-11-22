#!/bin/bash
git submodule foreach "git checkout;git pull --all; git merge maidsafe/next; git push"
git checkout next ;git pull --all; git merge maidsafe/next; git push

