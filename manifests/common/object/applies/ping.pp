class gernox_icinga2::common::object::applies::ping {
  ::icinga2::object::service { 'ping4':
    apply         => true,
    import        => [ 'generic-service' ],
    check_command => 'ping4',
    vars          => {
      ping_wrta => '$host.vars.services.ping.warning.rta$',
      ping_wpl  => '$host.vars.services.ping.warning.pl$',
      ping_crta => '$host.vars.services.ping.critical.rta$',
      ping_cpl  => '$host.vars.services.ping.critical.pl$',
    },
    assign        => [
      'host.address',
    ],
    target        => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }

  ::icinga2::object::service { 'ping6':
    apply         => true,
    import        => [ 'generic-service' ],
    check_command => 'ping6',
    vars          => {
      ping_wrta => '$host.vars.services.ping.warning.rta$',
      ping_wpl  => '$host.vars.services.ping.warning.pl$',
      ping_crta => '$host.vars.services.ping.critical.rta$',
      ping_cpl  => '$host.vars.services.ping.critical.pl$',
    },
    assign        => [
      'host.address6',
    ],
    target        => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
