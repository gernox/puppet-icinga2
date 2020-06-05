class gernox_icinga2::common::object::applies::icinga {
  ::icinga2::object::service { 'icinga':
    apply            => true,
    import           => [ 'generic-service' ],
    check_command    => 'icinga',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client',
    ],
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
