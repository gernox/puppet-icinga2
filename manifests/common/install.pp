# @summary
#   Installs icinga2 for clients and servers
#
class gernox_icinga2::common::install (
  String $zone = $gernox_icinga2::zone,
  String $type = $gernox_icinga2::type,
) {
  # Plugin packages to install
  $plugin_packages = [
    'nagios-plugins',
    'nagios-plugins-basic',
    'nagios-plugins-standard',
    'nagios-snmp-plugins',
    'nagios-plugins-contrib',
  ]

  $plugin_packages.each |$idx, $pkg| {
    if !defined(Package[$pkg]) {
      package { $pkg:
        ensure => present,
      }
    }
  }

  package { 'mailutils':
    ensure => present,
  }

  user { ['icinga', 'nagios']:
    ensure  => present,
    groups  => [
      # 'monitor',
      # 'ssl-cert',
      # 'Debian-exim',
      # 'storage'
    ],
    require => [
      # Group['monitor'],
      # Group['ssl-cert'],
      # Group['Debian-exim'],
      # Group['storage']
    ]
  }

  class { '::icinga2':
    manage_repo => true,
    features    => [],
    plugins     => [
      'plugins',
      'plugins-contrib',
    ],
    constants   => {
      'ZoneName' => $zone,
    }
  }

  file { "${::icinga2::globals::conf_dir}/zones.d":
    ensure  => if $type == 'server' { 'directory' } else { 'absent' },
    owner   => nagios,
    group   => nagios,
    recurse => true,
    purge   => true,
    force   => true,
    require => File[$::icinga2::globals::conf_dir],
  }

  file { "${::icinga2::globals::conf_dir}/conf.d":
    ensure  => directory,
    owner   => nagios,
    group   => nagios,
    recurse => true,
    purge   => true,
    require => File[$::icinga2::globals::conf_dir],
  }
}
