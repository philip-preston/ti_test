#!/bin/bash

# Change dir
cd /code

# Start lando
sudo -u lando lando start &> /dev/null

# Get lando settings
sudo -u lando lando info > lando.json

# Open network ports
# Get URL with port
url=$(jq -r '.edge.urls[0]' lando.json)
rm lando.json

# Extract port number
port=$(echo ${url} | tr -dc '0-9')

echo ''
echo "============================="
echo "= Dev: http://ti.test:${port} ="
echo "============================="
echo ''
