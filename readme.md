Manual steps:

ON AGENT

- sudo yum -y install puppet-agent
- sudo puppet config set server master.example.com --section main

ON MASTER

- sudo yum -y install puppetserver
- sudo puppet config set server master.example.com --section main
- sudo vim /etc/sysconfig/puppetserver, change heap size, otherwise it won't start on this VM. (They're gonna change the defaults, right?)
- sudo rm -rf /etc/puppetlabs/code/environments/production
- Do an `r10k deploy environment -p`

EVERYWHERE

- Get ssl certs signed
- Do a barrel roll ^H^H^H^H puppet run
