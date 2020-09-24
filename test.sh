#!/usr/bin/env bash

git switch -c "testbranch"
echo $(date) > datechange.txt
git add . datechange.txt

