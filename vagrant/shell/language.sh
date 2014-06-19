#! /bin/bash

# This script is executed while provisioning the vagrant virtual machine to
# correctly setup the locale and language in the VM prior to installing
# postgresql

rm -rf /etc/profile.d/lang.sh

echo 'export LANGUAGE=en_US.UTF-8' >> /etc/profile.d/lang.sh
echo 'export LANG=en_US.UTF-8' >> /etc/profile.d/lang.sh
echo 'export LC_ALL=en_US.UTF-8' >> /etc/profile.d/lang.sh
