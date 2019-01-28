#!/usr/bin/env bash

# If script was run as root, exit
if (( EUID == 0 )); then
   echo "This script must not be run as root"
   exit 1
fi

if [ ! -f /etc/httpd/conf.d/040_institutes.conf.httpd ]; then
  echo "Switching to new ti.org"

  echo "Starting Lando..."
  cd ../../
  lando start > /dev/null

  echo "Setting httpd config as a proxy for the new ti.org"
  sudo mv /etc/httpd/conf.d/040_institutes.conf /etc/httpd/conf.d/040_institutes.conf.httpd
  sudo cp provision/files/040_institutes.conf.lando /etc/httpd/conf.d/040_institutes.conf

  echo "Restarting httpd..."
  sudo systemctl restart httpd
else
  echo "Switching to existing ti.org"

  echo "Setting httpd config to handle ti.org requests"
  sudo mv /etc/httpd/conf.d/040_institutes.conf.httpd /etc/httpd/conf.d/040_institutes.conf

  echo "Restarting httpd..."
  sudo systemctl restart httpd

  echo "Stopping Lando..."
  cd ../../
  lando stop > /dev/null
fi
