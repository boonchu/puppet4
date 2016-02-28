class profile::web {

    class { 'apache':
        mpm_module => 'prefork',
    }

    include apache::mod::php

}
