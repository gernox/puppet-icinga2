class gernox_icinga2::common::object::applies::swap {
  ::icinga2::object::service { 'swap':
    apply            => true,
    import           => [ 'generic-service' ],
    check_command    => 'swap',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client && linux-servers in host.groups',
    ],
    ignore           => [
      'host.vars.services.swap.no_swap',
    ],
    vars             => {
      swap_wfree => '$host.vars.services.swap.wfree$',
      swap_cfree => '$host.vars.services.swap.cfree$',
    },
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
