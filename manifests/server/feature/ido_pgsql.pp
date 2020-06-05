class gernox_icinga2::server::feature::ido_pgsql (
  $host                 = '127.0.0.1',
  $port                 = 5432,
  $user                 = $::icinga2::db_user,
  $password             = $::icinga2::db_pass,
  $database             = $::icinga2::db_name,
  $table_prefix         = 'icinga_',
  $instance_name        = 'default',
  $instance_description = undef,
  $enable_ha            = true,
  $cleanup              = {
    acknowledgements_age           => 0,
    commenthistory_age             => 0,
    contactnotifications_age       => 0,
    contactnotificationmethods_age => 0,
    downtimehistory_age            => 0,
    eventhandlers_age              => 0,
    externalcommands_age           => 0,
    flappinghistory_age            => 0,
    hostchecks_age                 => 0,
    logentries_age                 => 0,
    notifications_age              => 0,
    processevents_age              => 0,
    statehistory_age               => 0,
    servicechecks_age              => 0,
    systemcommands_age             => 0,
  },
  $categories           = undef,

  $postgresql_version,
) {
  contain ::gernox_docker

  if !defined(Docker::Image["postgres:${postgresql_version}"]) {
    ::docker::image { "postgres:${postgresql_version}":
      ensure    => present,
      image     => 'postgres',
      image_tag => $postgresql_version,
    }
  }

  ::docker::run { 'icinga2-postgres':
    image                 => "postgres:${postgresql_version}",
    volumes               => [
      '/srv/docker/icinga2/postgresql/data:/var/lib/postgresql/data',
    ],
    health_check_interval => 30,
    env                   => [
      "POSTGRES_USER=${user}",
      "POSTGRES_PASSWORD=${password}",
      "POSTGRES_DB=${database}",
    ],
    ports                 => [
      "${port}:5432",
    ],
  }

  class { '::icinga2::feature::idopgsql':
    host                 => $host,
    port                 => $port,
    user                 => $user,
    password             => $password,
    database             => $database,
    table_prefix         => $table_prefix,
    instance_name        => $instance_name,
    instance_description => $instance_description,
    enable_ha            => $enable_ha,
    cleanup              => $cleanup,
    categories           => $categories,
    import_schema        => true,
    require              => Docker::Run['icinga2-postgres'],
  }
}
