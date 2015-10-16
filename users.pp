# Explore Puppet 4
#
# http://www.slideshare.net/roidelapluie/dive-into-puppet-4?qid=d8c4a9f1-bc8c-46b6-a5e8-a9d57e1d3a6c&v=default&b=&from_search=5
# https://docs.puppetlabs.com/references/latest/function.html
#
#   - Types in conditions
#   - Types in case statements 
#   - Types in parameters
#   - Types checking
#   
#   - Hashes merge
#   - Array merge
#   - No stdlib requires
#
#   - Loop Array
#   - Loop Hash
#   - Loop reduce
# 
#   - with 'private' scope
#   
define users(

  Boolean $m = true,
  $user = 1,
  Enum['mysql', 'mariadb'] $service_name,
  Array[String] $packages,
  Hash[String, String] $values,
  Array[Integer] $inta,
  Optional[String[8]] $root_password,

) {
  
  if $m =~ Boolean {

    $manage = $m
    notify { "[DEBUG]:: $manage": withpath=>true }

    case $user {
      Integer: { 
        $uid  = $user
        notify { "[DEBUG]:: $uid": withpath=>true }
      }
      Boolean: {
        $create = $user
        notify { "[DEBUG]:: $create": withpath=>true }
      }
      default: {
        fail('[DEBUG]:: Bad Data Type')
      }
    }

  } elsif $m !~ Enum['true', 'false'] {

    fail('[DEBUG]:: Bad value')

  }

  notify { "[DEBUG]:: $service_name": withpath=>true }
  notify { "[DEBUG]:: $root_password": withpath=>true }

  # Assert Type
  $runmode = assert_type(String, $facts['osfamily'])

  notify { "[DEBUG]:: $runmode": withpath=>true }

  # Merge Hash
  $mascot1 = { 'linux' => 'tux' }
  $mascot2 = { 'bsd' => 'beastie' }
  $mascots = $mascot1 + $mascot2
  notify { "[DEBUG]:: $mascots": withpath=>true }
  
  # Array Loop
  $packages.each | String $pkg | {
    notify { "[DEBUG]:: $pkg": withpath=>true }
  }

  # Hash Loop
  $values.each | String $_k, String $_v | {
    notify { "[DEBUG]:: $_k -> $_v": withpath=>true }
    # with 'private' scope 
    with($_k, $_v) | $_key, $_value | {
      file {
        "/tmp/${_key}": content => "${_key}:${_value}",
      }
    }
  }

  # Reduce Loop
  $sum = reduce($inta) |$result, $value| {
    $result + $value
  }
  notify { "[DEBUG]:: $sum": withpath=>true }

}

# user_info data
$_user_info = {
  'boonchu' => {
    'm'            => true,
    'service_name' => 'mysql',
    'packages'     => ['tmux', 'vim', 'ntop'],
    'values'       => {
      'key1' => 'value1',
      'key2' => 'value2',
    },
    'inta'         => [ 1, 2, 3, 4, 5, 6 ],
    'root_password' => 'abcd1234',
  },
  'nick' => {
    'm'            => false,
    'service_name' => 'mariadb',
    'packages'     => ['finger', 'cow', 'sysstat'],
    'values'       => {
      'key_a' => 'v1',
      'key_b' => 'v2',
    },
    'inta'         => [ 1, 2, 3, 4, 5, 6 ],
    'root_password' => 'defght6789',
  },
}

create_resources(users, $_user_info)
