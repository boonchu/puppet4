class profile::node_firewall {
    
    # purge unmanaged firewall resources
    resources { 'firewall':
        purge => true,
    }

    Firewall {
        before  => Class['profile::node_firewall::post'],
        require => Class['profile::node_firewall::pre'],
    }

    class { ['profile::node_firewall::pre', 'profile::node_firewall::post']: }

    class { '::firewall': }

}
