class gernox_icinga2::common::object::applies::reboot_required {
  ::icinga2::object::service { 'reboot_required':
    apply                => true,
    import               => [ 'daily-service' ],
    check_command        => 'reboot_required',
    command_endpoint     => 'host.vars.remote_client',
    assign               => [
      'host.vars.remote_client && host.vars.distro == Debian',
      'host.vars.remote_client && host.vars.distro == Ubuntu',
    ],
    enable_notifications => false,
    target               => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
