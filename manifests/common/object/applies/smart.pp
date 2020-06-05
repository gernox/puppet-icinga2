class gernox_icinga2::common::object::applies::smart {
  ::icinga2::object::service { 'smart_status':
    apply            => true,
    import           => [ 'hourly-service' ],
    check_command    => 'smart_status',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client && host.vars.disks',
    ],
    vars             => {
      disks => '$host.vars.disks$',
    },
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
