###### Puppet Homework ######

* How to start with Puppet Vagrant environment 
  
   -  url: https://doauto.wordpress.com/2013/06/22/how-to-change-a-file-using-puppet/

* start with magmum

```
$ magnum module create "[MODULE NAME]"

$ cd "[MODULE NAME]"

$ tree templates/ manifests/
templates/
└── probeme.erb
manifests/
├── init.pp
└── params.pp
```

* start with init.pp, see from example "samples"

```
$ vagrant up
```

###### Puppet Parser Future #####

* How to include puppet stdlib to support parser future

```
samples/.fixtures.yml
+  repositories:
+    stdlib: 'https://github.com/puppetlabs/puppetlabs-stdlib.git'
```

* Adding parser future to Vagrantfile (do not need when use Puppet 4)

```
+    puppet.options = "--debug"
+    puppet.options = "--parser future"
```

* Testing each() function

```
+    $n = range('1', $::samples::instances)
+    if $n {
+      validate_array($n)
+    }
+
+    notify {"[DEBUG] setup multiple samples :: ${n}": withpath => true}
+
+    each($n) |$instance| {
+
+      $counter = 30 + $instance
+
+      file { "/var/log/files-16${counter}":
+        ensure => 'directory',
+        owner  => $owner,
+        group  => $group,
+        mode   => '0555',
+      }
+
+    }
+
```

###### Puppet Hiera Testing ######
  * https://docs.puppetlabs.com/references/latest/function.html

```
+    # heira params
+    $snmp_stats     = $samples::params::snmp_stats,
+    $memcache_host  = $samples::params::memcache_host,
+    $memcache_port  = $samples::params::memcache_port,
+    $memcache_stats = $samples::params::memcache_stats,
+

+    # get hiera parameters and throw into this line
+    notify {"[DEBUG] setup multiple files :: ${snmp_stats}": withpath => true}
+    notify {"[DEBUG] setup multiple files :: ${memcache_host}": withpath => true}
+    notify {"[DEBUG] setup multiple files :: ${memcache_port}": withpath => true}
+    notify {"[DEBUG] setup multiple files :: ${memcache_stats}": withpath => true}
+

+    # hiera params into class "samples"
+    $snmp_stats     = hiera_hash('snmp_stats', {})
+    $memcache_stats = hiera_array('memcache_stats', [])
+    $memcache_host  = hiera('memcache_host', 'localhost')
+    $memcache_port  = hiera('memcache_port', '11212')
+
```

###### Puppet Design: Roles Profiles Coding Pattern #######
  * https://github.com/hunner/roles_and_profiles.git
