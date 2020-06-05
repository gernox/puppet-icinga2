class gernox_icinga2::common::object::applies::ntp {
  ::icinga2::object::service { 'ntp_time':
    apply            => true,
    import           => [ 'daily-service' ],
    check_command    => 'ntp_time',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client && linux-servers in host.groups && host.vars.services.ntp.address',
    ],
    ignore           => [
      'virtual-machines in host.groups',
    ],
    vars             => {
      ntp_address => '$host.vars.services.ntp.address$',
    },
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
