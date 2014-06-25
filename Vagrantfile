# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "chef/ubuntu-14.04"

  # Use a dedicated private network
  config.vm.network :private_network, ip: "10.0.0.2"

  #This way you can access the VM from your network
  config.vm.network :forwarded_port, host: 3000, guest: 3000

  # Use NFS instead of the default shared folder
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  # When using NFS, it's very important to keep clocks synced very closely.
  # Reset time if it gets out of sync for more than 0.5 seconds
  config.vm.provider :virtualbox do |vb|
    vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 500 ]
  end

  # Configure the basic infrastructure to setup chef
  config.vm.provision :shell, path: "vagrant/shell/chef.sh"

  # Configure chef provisioners
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "vagrant/cookbooks"

    chef.json = {
      authorization: {
        sudo: {
          users: ["vagrant"],
          passwordless: true
        }
      },

      rvm: {
        user_installs: [{
          user: "vagrant",
          default_ruby: "2.1.1",
        }]
      }
    }

    chef.add_recipe "apt"
    chef.add_recipe "sudo::default"
    chef.add_recipe "rvm::user"
    chef.add_recipe "rvm::vagrant"
    chef.add_recipe "nfs"
    chef.add_recipe "nodejs"
  end
end
