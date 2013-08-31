class apt-cacher-ng (
  $version = 'installed',
  $config_source = 'puppet:///modules/apt-cacher-ng/acng.conf',
) {
  package { 'apt-cacher-ng':
    ensure => $version,
  }

  service { 'apt-cacher-ng':
    ensure  => running,
    require => Package['apt-cacher-ng'],
  }

  file { '/etc/apt-cacher-ng/acng.conf':
    source => ["puppet:///modules/site-apt-cacher-ng/${::fqdn}/acng.conf",
               'puppet:///modules/site-apt-cacher-ng/acng.conf',
               $config_source],
    notify  => Service['apt-cacher-ng'],
    require => Package['apt-cacher-ng'],
  }

  file { '/var/cache/apt-cacher-ng':
    ensure  => directory,
    owner   => 'apt-cacher-ng',
    require => Package['apt-cacher-ng'],
  }
}
