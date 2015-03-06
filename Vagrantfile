# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # https://docs.vagrantup.com.

  # boxes at https://vagrantcloud.com/puppetlabs. you want one of the "-nocm" ones.
  config.vm.box = "puppetlabs/centos-7.0-64-nocm"
  # I think this box defaults to 512 MB ram and 1 CPU.

  # enable vagrant-hostmanager plugin (vagrant plugin install vagrant-hostmanager)
  config.hostmanager.enabled = true
  # this one lets it manage a fenced-off part of /etc/hosts on your host machine, so you can access your VMs with a web browser or whatevs.
  config.hostmanager.manage_host = true

  config.vm.define 'master' do |node|
    node.vm.hostname = 'master.example.com'
    node.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
    end
  end

  # How many agents do you want?
  agents = 1

  agents.times do |i|
    agent_id = i.next.to_s
    config.vm.define "agent#{agent_id}" do |node|
      node.vm.hostname = "agent#{agent_id}.example.com"
    end

  end

  # forwarded port example: "localhost:8080" will access port 80 on guest
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # shared folder example: The first argument is path on the host; second argument is
  # the path on the guest; optional third argument is options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Add latest nightly foss repos:
  config.vm.provision "shell", inline: <<-SHELL
    cd /etc/yum.repos.d
    sudo wget http://nightlies.puppetlabs.com/puppet-agent-latest/repo_configs/rpm/pl-puppet-agent-latest-el-7-x86_64.repo
    sudo wget http://nightlies.puppetlabs.com/puppetserver-latest/repo_configs/rpm/pl-puppetserver-latest-el-7-x86_64.repo
    sudo wget http://nightlies.puppetlabs.com/puppetdb-latest/repo_configs/rpm/pl-puppetdb-latest-el-7-x86_64.repo
    sudo yum -y install tree vim-enhanced git
  SHELL
end
