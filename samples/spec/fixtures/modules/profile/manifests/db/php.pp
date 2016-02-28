class profile::db::php {

    class { '::mysql::bindings':
        php_enable => true,
    }

}
