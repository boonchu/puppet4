class profile::node_firewall::post {

  firewall { '999 drop all':
      proto  => 'all',
      action => 'drop',
      before => undef,
  }

}
