class nginx {

  package { 'nginx':
    ensure => installed,
  } ->

  file { '/etc/nginx/sites-enabled/site':
    content => template('nginx/site.erb'),
  } ~>

  service { 'nginx':
    subscribe => Package['nginx'],
    ensure => running,
    restart => true,
  }

}