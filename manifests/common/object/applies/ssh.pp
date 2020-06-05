class gernox_icinga2::common::object::applies::ssh {
  ::icinga2::object::service { 'ssh':
    apply         => true,
    import        => [ 'generic-service' ],
    check_command => 'ssh',
    assign        => [
      '(host.address || host.address6) && linux-servers in host.groups',
    ],
    target        => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
