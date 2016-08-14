# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT
echo I am provisioning...
date > /etc/vagrant_provisioned_at
apt-get update && apt-get install -y python-pip
if [ -f /vagrant/custom_ca.crt ]; then sudo cp /vagrant/custom_ca.crt /usr/local/share/ca-certificates/ && sudo update-ca-certificates; fi
cd /vagrant && pip install -r requirements.txt
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 5000, host: 5000

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/vagrant"

  # build flask env
  config.vm.provision "shell", inline: $script

end
