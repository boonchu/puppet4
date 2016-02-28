class profile::db {

    $override_options = {
        'mysqld' => {
            'replicate-do-db' => ['base1', 'base2'],
        }
    }

    class { '::mysql::server':
        root_password           => 'strongpassword',
        remove_default_accounts => true,
        override_options        => $override_options,
    }

}
