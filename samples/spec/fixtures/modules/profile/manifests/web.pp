class profile::web {

    class { 'apache':
        mpm_module => 'prefork',
    }

    include apache::mod::php
    include profile::node_firewall::web

}
