class gernox_icinga2::common::object::applies::bareos {
  ::icinga2::object::service { 'bareos_status':
    apply            => true,
    import           => [ 'hourly-service' ],
    display_name     => 'Bareos Backup Empty Backups',
    check_command    => 'bareos_status',
    command_endpoint => 'host.vars.remote_client',
    vars             => {
      bareos_database     => '$host.vars.services.bareos.database$',
      bareos_user         => '$host.vars.services.bareos.user$',
      bareos_password     => '$host.vars.services.bareos.password$',
      bareos_host         => '$host.vars.services.bareos.host$',
      bareos_port         => '$host.vars.services.bareos.port$',
      bareos_emptybackups => '$host.vars.services.bareos.status.emptybackups$',
      bareos_full         => true,
      warning             => '$host.vars.services.bareos.status.warning$',
      critical            => '$host.vars.services.bareos.status.critical$',
    },
    assign           => [
      'host.vars.remote_client && host.vars.services.bareos.status',
    ],
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }

  ::icinga2::object::service { 'bareos_failed':
    apply            => true,
    import           => [ 'hourly-service' ],
    display_name     => 'Bareos Backup Failed Backups',
    check_command    => 'bareos_failed',
    command_endpoint => 'host.vars.remote_client',
    vars             => {
      bareos_database      => '$host.vars.services.bareos.database$',
      bareos_user          => '$host.vars.services.bareos.user$',
      bareos_password      => '$host.vars.services.bareos.password$',
      bareos_host          => '$host.vars.services.bareos.host$',
      bareos_port          => '$host.vars.services.bareos.port$',
      bareos_failedbackups => '$host.vars.services.bareos.failed.failedbackups$',
      warning              => '$host.vars.services.bareos.failed.warning$',
      critical             => '$host.vars.services.bareos.failed.critical$',
    },
    assign           => [
      'host.vars.remote_client && host.vars.services.bareos.failed',
    ],
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
