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

  package { 'php5-imagick':
    ensure => 'installed',
  }

  package { 'php5-intl':
    ensure => 'installed',
  }

  package { 'php5-memcache':
    ensure => 'installed',
  }

  package { 'php5-mcrypt':
    ensure => 'installed',
  }

  package { 'php5-mysql':
    ensure => 'installed',
  }

  package { 'php-pear':
    ensure => 'installed',
  }

  file { 'php-fpm.conf':
    path => '/etc/php5/fpm/php-fpm.conf',
    content => template('php/php-fpm.conf.erb'),
  }

  file { 'php-fpm.ini':
    path => '/etc/php5/fpm/php-fpm.ini',
    content => template('php/php-fpm.ini.erb'),
  }

  file { 'php-cli.ini':
    path => '/etc/php5/fpm/php-cli.ini',
    content => template('php/php-cli.ini.erb'),
  }

  file { 'php-apache2.ini':
    path => '/etc/php5/apache2/php.ini',
    content => template('php/php-apache2.ini.erb'),
  }

  service { 'php-fpm':
    name => 'php5-fpm',
    restart => true,
  }

  service { 'apache2':
    name => 'apache2',
    restart => true,
  }

  File['php-fpm.conf'] ~> Service['php-fpm']
  File['php-fpm.ini'] ~> Service['php-fpm']
  File['php-apache2.ini'] ~> Service['apache2']

  # pecl stuff
  exec { "pear upgrade":
    require => Package["php-pear"]
  }

  exec { "pear auto_discover":
    command => "pear config-set auto_discover 1",
    require => Exec["pear upgrade"]
  }

/*
  exec { "apcu":
    command => "pecl install apcu",
    require => [Package["php-pear"], Exec["pear upgrade"]],
    unless => "php -i | grep apc"
  }
*/

  exec { "xdebug":
    command => "pecl install xdebug",
    require => [Package["php-pear"], Exec["pear upgrade"]],
    unless => "php -i | grep xdebug"
  }

}