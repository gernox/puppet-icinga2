class gernox_icinga2::common::object::applies::systemd {
  ::icinga2::object::service { 'systemd_service':
    import           => [ 'generic-service' ],
    apply            => 'identifier => config in host.vars.services.systemd',
    display_name     => 'systemd-service',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client && linux-servers in host.groups',
    ],
    check_command    => 'systemd_service',
    vars             => 'vars + config',
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }

  ::icinga2::object::service { 'systemd_system':
    import               => [ 'generic-service' ],
    apply                => true,
    display_name         => 'systemd-status',
    command_endpoint     => 'host.vars.remote_client',
    assign               => [
      'host.vars.remote_client && linux-servers in host.groups',
    ],
    check_command        => 'check_systemd_system',
    enable_notifications => false,
    target               => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
