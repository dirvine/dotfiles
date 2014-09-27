#!/bin/bash
git submodule foreach "git pull --all; git merge maidsafe/next; git push"
git pull --all; git merge maidsafe/next; git push
