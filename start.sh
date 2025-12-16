#!/bin/bash
cd /opt/render/project/src
sleep 80
mkdir -p server && echo "OK" > server/index.html
python3 -m http.server 18080 -d server &
python3 bot.py
