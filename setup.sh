#!/bin/bash

clear

echo "[*] 1/3 Initializing volumes"
echo "############################"
./compose-up.sh
./compose-down.sh

echo ""
echo "[*] 2/3 Copying configuration files"
echo "############################"
./volume-copy.sh

echo ""
echo "[*] 3/3 Starting our containers"
echo "############################"
./compose-up.sh
