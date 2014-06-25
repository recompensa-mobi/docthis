#! /bin/bash

echo "Checking if chef solo is installed"

if [[ "$(which chef-solo)" == '' ]]; then
  echo "Installing chef development kit"
  INSTALLER=`mktemp`

  echo "Downloading chef development kit installer"
  wget --progress=dot:giga -O $INSTALLER https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/13.10/x86_64/chefdk_0.1.0-1_amd64.deb

  echo "Installing chef development kit"
  sudo dpkg -i $INSTALLER
fi

echo "Chef infrastructure bootstrap complete"
