Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

Exec["apt-update"] -> Package <| |>

exec { 'apt-update':
  command => 'apt-get update -y'
}

hiera_include('classes')