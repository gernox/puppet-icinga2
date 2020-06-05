class gernox_icinga2::common::object::applies::procs {
  ::icinga2::object::service { 'procs':
    apply            => true,
    import           => [ 'generic-service' ],
    check_command    => 'procs',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client && linux-servers in host.groups',
    ],
    vars             => {
      procs_warning  => '$host.vars.services.procs.warning$',
      procs_critical => '$host.vars.services.procs.critical$'
    },
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
