# @summary
#   Manages IcingaWeb2
#
# @param postgresql_version
#
# @param db_user
#
# @param db_password
#
# @param db_name
#
# @param db_port
#
# @param ido_db_user
#
# @param ido_db_password
#
# @param ido_db_name
#
# @param manage_apache
#
# @param http_port
#
class gernox_icinga2::icingaweb2 (
  String $postgresql_version,
  String $db_user,
  String $db_password,
  String $db_name,
  Integer $db_port,

  String $ido_db_user,
  String $ido_db_password,
  String $ido_db_name,
  Variant[String, Integer] $ido_db_port,

  String $api_user,
  String $api_password,

  Boolean $manage_apache,
  Integer $http_port,
) {

  contain ::gernox_docker

  if !defined(Docker::Image["postgres:${postgresql_version}"]) {
    ::docker::image { 'postgres':
      ensure    => present,
      image     => 'postgres',
      image_tag => $postgresql_version,
    }
  }

  ::docker::run { 'icingaweb2-postgres':
    image                 => "postgres:${postgresql_version}",
    volumes               => [
      '/srv/docker/icingaweb2/postgresql/data:/var/lib/postgresql/data',
    ],
    health_check_interval => 30,
    env                   => [
      "POSTGRES_USER=${db_user}",
      "POSTGRES_PASSWORD=${db_password}",
      "POSTGRES_DB=${db_name}",
    ],
    ports                 => [
      "${db_port}:5432",
    ],
  }

  class { '::icingaweb2':
    manage_repo   => false,
    import_schema => true,
    db_type       => 'pgsql',
    db_host       => 'localhost',
    db_port       => $db_port,
    db_username   => $db_user,
    db_password   => $db_password,
  }

  class { '::icingaweb2::module::monitoring':
    ido_type          => 'pgsql',
    ido_host          => 'localhost',
    ido_port          => 0 + $ido_db_port,
    ido_db_username   => $ido_db_user,
    ido_db_name       => $ido_db_name,
    ido_db_password   => $ido_db_password,
    commandtransports => {
      icinga2 => {
        transport => 'api',
        username  => $api_user,
        password  => $api_password,
      },
    },
  }

  if $manage_apache {
    class { 'apache':
      mpm_module    => 'prefork',
      default_vhost => false,
    }

    class { 'apache::mod::php':
      php_version => '7.2',
    }

    package { 'php7.2-pgsql':
      ensure  => present,
      require => Class['apache::mod::php'],
    }

    class { 'apache::mod::rewrite': }

    apache::vhost { 'default-icingaweb2':
      default_vhost => false,
      servername    => 'default',
      port          => $http_port,
      docroot       => '/var/www/html',
    }

    file { '/etc/apache2/conf.d/icingaweb2.conf':
      source  => 'puppet:///modules/gernox_icinga2/icingaweb2/icingaweb2.conf',
      require => Class['apache'],
      notify  => Service['apache2'],
    }
  }

}
