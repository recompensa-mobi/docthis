#! /bin/bash

echo "Checking if chef solo is installed"

if [[ "$(which chef-solo)" == '' ]]; then
  "Installing chef solo"
  wget -O - https://www.opscode.com/chef/install.sh | sudo bash
fi

echo "Chef infrastructure bootstrap complete"
