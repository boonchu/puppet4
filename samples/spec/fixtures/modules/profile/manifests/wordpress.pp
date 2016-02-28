class profile::wordpress {

    include profile::web
    
    group { 'wordpress':
        ensure => 'present',
    }

    user { 'wordpress':
        ensure   => 'present',
        gid      => 'wordpress',
        password => '$1$jrm5tnjw$h8JJ9mCZLmJvIxvDLjw1M/', # puppet
        home     => '/var/www/site/blog',
    }

}
