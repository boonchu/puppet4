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

    class { '::wordpress':
        install_dir => '/var/www/site/blog',
        install_url => 'http://wordpress.org',
        version     => '4.4.2',
        wp_lang     => '',
        db_name     => 'wordpress',
        db_host     => 'localhost',
        db_user     => 'wordpress',
        db_password => 'wordpress',
        wp_owner    => 'wordpress',
        wp_group    => 'wordpress',
    }

    apache::vhost { $::fqdn:
        port          => '80',
        docroot       => '/var/www/site',
        default_vhost => true,
    }

}
