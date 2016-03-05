node default {
    
  include samples

  # Try to autoload role manifests
  if $::role {
    include "::role::${::role}"
  }

}
