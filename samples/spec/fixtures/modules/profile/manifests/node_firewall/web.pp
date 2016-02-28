class profile::node_firewall::web {

    firewall { '001 disallow esp protocol':
        action => 'accept',
        proto  => '! esp',
    }
    ->
    firewall { '002 drop NEW external website packets with FIN/RST/ACK set and SYN unset':
        chain     => 'INPUT',
        state     => 'NEW',
        action    => 'drop',
        proto     => 'tcp',
        sport     => ['! http', '! 443'],
        source    => '! 192.168.0.0/16',
        tcp_flags => '! FIN,SYN,RST,ACK SYN',
    }
    ->
    firewall { '100 allow http and https access':
        dport   => [80, 443],
        proto  => tcp,
        action => accept,
    }

}
