class gernox_icinga2::common::object::applies::mailq {
  ::icinga2::object::service { 'exim':
    apply            => true,
    import           => [ 'generic-service' ],
    check_command    => 'gernox_mailq',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client && linux-servers in host.groups',
    ],
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
