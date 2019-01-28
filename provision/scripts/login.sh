#!/usr/bin/env bash

# If script was run as root, exit
if (( EUID == 0 )); then
   echo "This script must not be run as root"
   exit 1
fi

# Load config file
. ../env.config

cd ../..
lando terminus auth:login --machine-token="${PANTHEON_TOKEN}"
