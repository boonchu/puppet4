# == Class: samples
#
# files - contains files
#
# === Parameters
#
# [*say_hello_to*]
#
# [*myname*]
#
# === Authors
#
# Author Name bigchoo@gmail.com
#
class samples (

    $probeme      = 'samples/probeme.erb',

    $say_hello_to = $samples::params::say_hello_to,
    $myname       = $samples::params::myname,

    # parser future
    $instances    = $samples::params::instances,
    $owner        = $samples::params::owner,
    $group        = $samples::params::group,

    # template
    $redis_conf   = 'samples/redis.conf.erb',
    $options_hash = { },

    # heira params
    $snmp_stats     = $samples::params::snmp_stats,
    $memcache_host  = $samples::params::memcache_host,
    $memcache_port  = $samples::params::memcache_port,
    $memcache_stats = $samples::params::memcache_stats,

) inherits samples::params {

    file { "/tmp/${myname}":
        ensure  => 'file',
        content => template($::samples::probeme),
    }

    # http://www.example42.com/2014/10/29/reusability-features-every-module-should-have/
    # example redis templat
    file { '/etc/redis.conf':
        ensure  => 'file',
        content => template($::samples::redis_conf),
    }

    $n = range('1', $::samples::instances)
    if $n {
      validate_array($n)
    }

    notify {"[DEBUG] setup multiple files :: ${n}": withpath => true}

    each($n) |$instance| {

      $counter = 30 + $instance

      file { "/var/log/files-16${counter}":
        ensure => 'directory',
        owner  => $::samples::owner,
        group  => $::samples::group,
        mode   => '0555',
      }

    }

    # get hiera parameters and throw into this line
    notify {"[DEBUG] setup multiple files :: ${snmp_stats}": withpath => true}
    notify {"[DEBUG] setup multiple files :: ${memcache_host}": withpath => true}
    notify {"[DEBUG] setup multiple files :: ${memcache_port}": withpath => true}
    notify {"[DEBUG] setup multiple files :: ${memcache_stats}": withpath => true}

}
