class gernox_icinga2::common::object::applies::apt {
  ::icinga2::object::service { 'apt':
    apply                => true,
    import               => [ 'hourly-service' ],
    check_command        => 'apt',
    command_endpoint     => 'host.vars.remote_client',
    assign               => [
      'host.vars.remote_client && host.vars.distro == Debian',
      'host.vars.remote_client && host.vars.distro == Ubuntu',
    ],
    enable_notifications => false,
    target               => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
