#/bin/bash
sed -i "s/client-whitelist: \[\]/client-whitelist: [\"master.example.com\"]/" /etc/puppetlabs/puppetserver/conf.d/puppetserver.conf
sed -i "s/-Xms2g -Xmx2g/-Xms1g -Xmx1g/" /etc/sysconfig/puppetserver
