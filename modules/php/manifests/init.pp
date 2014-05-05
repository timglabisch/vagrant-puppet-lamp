class php {

  package { 'php5':
    ensure => 'installed',
  }

  package { 'php5-cli':
    ensure => 'installed',
  }

  package { 'php5-fpm':
    ensure => 'installed',
  }

  package { 'php5-dev':
    ensure => 'installed',
  }

  package { 'php-pear':
    ensure => 'installed',
  }

  file { 'php-fpm.conf':
    path => '/etc/php5/fpm/php-fpm.conf',
    content => template('php/php-fpm.conf.erb'),
  }

  service { 'php-fpm':
    name => 'php5-fpm',
    restart => true,
  }

  File['php-fpm.conf'] ~> Service['php-fpm']

}