# GET RID OF THIS ASAP. Seriously, this is stupid and brittle and dangerous. As soon as TK-167 is fixed, kill it!
file_line {'add master to client whitelist':
  path => '/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf',
  line => '    client-whitelist: ["master.example.com"]',
  match => '^[ \t]+client-whitelist: *\[([^\]]*)\][ \t]*$',
}

# GET RID OF THIS AS SOON AS THEY MAKE PUPPETSERVER DEFAULTS LESS HEAVY
file_line {'set heap size for puppetserver':
  path => '/etc/sysconfig/puppetserver',
  line => 'JAVA_ARGS="-Xms1g -Xmx1g -XX:MaxPermSize=256m"',
  match => '^JAVA_ARGS',
}
