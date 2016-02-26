# Class contains parameter value
class samples::params {

    $say_hello_to = 'mickey_mouse'
    $myname       = 'file03'
    $instances     = '5'
    $owner        = 'root'
    $group        = 'root'

    # hiera params into class "files"
    $snmp_stats     = hiera_hash('snmp_stats', {})
    $memcache_stats = hiera_array('memcache_stats', [])
    $memcache_host  = hiera('memcache_host', 'localhost')
    $memcache_port  = hiera('memcache_port', '11212')

}
