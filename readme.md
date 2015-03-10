Manual steps:

ON AGENT
-----

sudo yum -y install puppet-agent
sudo /opt/puppetlabs/bin/puppet apply /vagrant/symlinks.pp
sudo puppet config set server master.example.com

ON MASTER
-----

sudo -i

### Get things

yum -y install puppetserver
/opt/puppetlabs/bin/puppet apply /vagrant/symlinks.pp
/opt/puppetlabs/puppet/bin/gem install r10k --no-ri --no-rdoc --verbose

### Get my environments

rm -rf /etc/puppetlabs/code/environments/production
r10k deploy environment -p

### Configure crap, make vim act the way I'm used to

puppet apply /etc/puppetlabs/code/environments/production/manifests

### Edit config files for basic sense

puppet config set server master.example.com
vim /etc/puppetlabs/puppetserver/conf.d/puppetserver.conf
    - add "master.example.com" to the puppet-admin cert whitelist (can't wait 'til there's a module for that)
vim /etc/sysconfig/puppetserver
    - change heap size, otherwise it won't start on this VM. (They're gonna change the defaults, right?)

EVERYWHERE
-----

- Get ssl certs signed
- Do a barrel roll ^H^H^H^H puppet run

On the master, you can run `sudo trash_envs` to ping the environment-cache endpoint.
