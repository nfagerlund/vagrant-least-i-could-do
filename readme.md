Manual steps:

ON AGENT

- sudo yum -y install puppet-agent
- sudo /opt/puppetlabs/bin/puppet apply /vagrant/symlinks.pp
- sudo puppet config set server master.example.com

ON MASTER

- sudo yum -y install puppetserver
- sudo /opt/puppetlabs/bin/puppet apply /vagrant/symlinks.pp
- sudo /opt/puppetlabs/puppet/bin/gem install r10k --no-ri --no-rdoc --verbose
- sudo puppet config set server master.example.com
- sudo vim /etc/sysconfig/puppetserver, change heap size, otherwise it won't start on this VM. (They're gonna change the defaults, right?)
- sudo rm -rf /etc/puppetlabs/code/environments/production
- Do an `r10k deploy environment -p`

EVERYWHERE

- Get ssl certs signed
- Do a barrel roll ^H^H^H^H puppet run
