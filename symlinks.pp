[
  "cfacter",
  "facter",
  "hiera",
  "mco",
  "puppet",
  "puppetserver",
].each |$binary| {

  # /usr/local/bin is disliked by sudo on centos. >:|
  file {"/usr/bin/$binary":
    ensure => link,
    target => "/opt/puppetlabs/bin/$binary",
  }

}

file {"/usr/bin/r10k":
  ensure => link,
  target => "/opt/puppetlabs/puppet/bin/r10k",
}

# This will only work on the master, and only if your user has read access to
# the master's private key, so it's okay if it's world-executable.
file {"/usr/bin/trash_envs":
  ensure  => file,
  content => "#!/usr/bin/sh\n\ncurl -i --cert /etc/puppetlabs/puppet/ssl/certs/master.example.com.pem --key /etc/puppetlabs/puppet/ssl/private_keys/master.example.com.pem --cacert /etc/puppetlabs/puppet/ssl/certs/ca.pem -X DELETE https://master.example.com:8140/puppet-admin-api/v1/environment-cache \n",
  mode    => '0755',
}
