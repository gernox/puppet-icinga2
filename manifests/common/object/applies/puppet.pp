class gernox_icinga2::common::object::applies::puppet {
  ::icinga2::object::service { 'puppet_agent':
    apply                => true,
    import               => [ 'generic-service' ],
    check_command        => 'puppet_agent',
    command_endpoint     => 'host.vars.remote_client',
    assign               => [
      'host.vars.remote_client && host.vars.distro == Debian',
      'host.vars.remote_client && host.vars.distro == Ubuntu',
    ],
    ignore               => [
      'host.vars.services.puppet.disable',
    ],
    enable_notifications => false,
    target               => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
