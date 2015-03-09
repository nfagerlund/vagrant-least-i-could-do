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
