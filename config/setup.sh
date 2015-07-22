#!/bin/bash

cd /soldat/
echo "setup game in $(pwd)"
chmod +x soldatserver
chmod -R 0777 logs
chmod -R u+w ./logs/
chmod -R u+w ./anti-cheat/
chmod 666 banned*.txt

