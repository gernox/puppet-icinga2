class gernox_icinga2::common::object::applies::disk {
  ::icinga2::object::service { 'disk':
    apply            => true,
    import           => [ 'hourly-service' ],
    check_command    => 'disk',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client && linux-servers in host.groups',
    ],
    vars             => {
      disk_wfree            => '$host.vars.services.disk.wfree$',
      disk_cfree            => '$host.vars.services.disk.cfree$',
      disk_inode_wfree      => '$host.vars.services.disk.inode_wfree$',
      disk_inode_cfree      => '$host.vars.services.disk.inode_cfree$',
      disk_megabytes        => true,
      disk_all              => true,
      disk_local            => true,
      disk_ignore_ereg_path => '$host.vars.services.disk.ignore_regexp$',
      disk_exclude_type     => '$host.vars.services.disk.exclude_type$',
    },
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
