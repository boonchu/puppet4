define student ($full_name) {
  notify { "user ${title}":
    message => "username: ${title}\n",
  }
  notify { "fullname ${title}":
    message => "fullname: ${full_name}\n",
  }
  exec { "finger ${title}":
    command   => "/usr/bin/finger ${title}",
    logoutput => true,
  }
}

$users = {
  elion => { full_name => 'El Lion'   },
  azee  => { full_name => 'Avery Zee' },
  root  => { full_name => 'Rooty Root' },
}

create_resources(student, $users)
