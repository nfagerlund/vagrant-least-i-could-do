# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # https://docs.vagrantup.com.

  require 'yaml'
  require 'pathname'
  config_file = Pathname.new(__FILE__).parent + 'vagrant_config.yaml'
  config_data = YAML.load(config_file.read)

  # How many agents do you want?
  agents = config_data['agents'] || 1

  # boxes at https://vagrantcloud.com/puppetlabs. you want one of the "-nocm" ones.
  config.vm.box = "puppetlabs/centos-7.0-64-nocm"
  # I think this box defaults to 512 MB ram and 1 CPU.

  # enable vagrant-hostmanager plugin (vagrant plugin install vagrant-hostmanager)
  config.hostmanager.enabled = true
  # this one lets it manage a fenced-off part of /etc/hosts on your host machine, so you can access your VMs with a web browser or whatevs.
  config.hostmanager.manage_host = config_data['dns_on_host'] || false

  # Stop firewalls, add latest nightly foss repos, get vim & tree, prep r10k
  provision_basic = <<-SHELL
    service firewalld stop
    cd /etc/yum.repos.d
    wget http://nightlies.puppetlabs.com/puppet-agent-latest/repo_configs/rpm/pl-puppet-agent-latest-el-7-x86_64.repo
    wget http://nightlies.puppetlabs.com/puppetserver-latest/repo_configs/rpm/pl-puppetserver-latest-el-7-x86_64.repo
    wget http://nightlies.puppetlabs.com/puppetdb-latest/repo_configs/rpm/pl-puppetdb-latest-el-7-x86_64.repo
    yum -y install tree vim-enhanced git
    mkdir /var/cache/r10k
    cp /vagrant/r10k.yaml /etc/r10k.yaml
  SHELL

  provision_install_agent = provision_basic + <<-AGENT
    yum -y install puppet-agent
    /opt/puppetlabs/bin/puppet apply /vagrant/symlinks.pp
    puppet config set server master.example.com
  AGENT

  list_of_agents = (1..agents).map {|i| "agent#{i}.example.com"}.join("\n")

  # Last line is hairy master config stuff that needs revision
  provision_install_master = provision_install_agent + <<-MASTER
    yum -y install puppetserver
    echo "PARDON THE WAIT HERE, Installing r10k takes like forever."
    /opt/puppetlabs/puppet/bin/gem install r10k --no-ri --no-rdoc --verbose

    echo "#{list_of_agents}" > /etc/puppetlabs/puppet/autosign.conf

    rm -rf /etc/puppetlabs/code/environments/production
    r10k deploy environment -p

    puppet apply /vagrant/master-config-edits.pp
  MASTER

  config.vm.define 'master' do |node|
    node.vm.hostname = 'master.example.com'
    node.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
    end
    node.vm.provision "shell", privileged: true, inline: config_data['auto_install'] ? provision_install_master : provision_basic
  end

  (1..agents).each do |i|
    config.vm.define "agent#{i}" do |node|
      node.vm.hostname = "agent#{i}.example.com"
      node.vm.provision "shell", privileged: true, inline: config_data['auto_install'] ? provision_install_agent : provision_basic
    end
  end

  # forwarded port example: "localhost:8080" will access port 80 on guest
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # shared folder example: The first argument is path on the host; second argument is
  # the path on the guest; optional third argument is options.
  # config.vm.synced_folder "../data", "/vagrant_data"
end
