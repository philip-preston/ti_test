#!/usr/bin/env bash

cd /code

# Stop Lando
type lando > /dev/null && sudo -u lando lando stop &> /dev/null
