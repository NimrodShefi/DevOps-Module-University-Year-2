#!/bin/bash

echo "cd to root directory..."
cd root

echo "whoami..."
whoami

echo "pwd..."
pwd

# commented out to speed things up, do not do this in production
# echo "upgrading..."
# sudo yum upgrade -y