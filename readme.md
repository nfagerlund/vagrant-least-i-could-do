The shell provisioner should set up basically everything, but we're not installing puppetdb yet.

Remaining manual step is to SSH in, start services, and start doing runs.

On the master, you can run `sudo trash_envs` to ping the environment-cache endpoint.

## TODOs

A really gross thing I do in provisioning: use file_line resources to edit the master's config files.

* /etc/puppetlabs/puppetserver/conf.d/puppetserver.conf: add "master.example.com" to the puppet-admin cert whitelist.
    - This is waiting on TK-167 to let us manage the whitelist safely
* /etc/sysconfig/puppetserver: change heap size, otherwise it won't even start on this VM.
    - This is waiting on the work around smarter default JVM settings, to hopefully obviate the need for changing heap at all.

