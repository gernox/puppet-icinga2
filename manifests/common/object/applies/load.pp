class gernox_icinga2::common::object::applies::load {
  ::icinga2::object::service { 'load':
    apply            => true,
    import           => [ 'generic-service' ],
    check_command    => 'load',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client && linux-servers in host.groups',
    ],
    vars             => {
      load_wload1  => '$host.vars.services.load.wload1$',
      load_wload5  => '$host.vars.services.load.wload5$',
      load_wload15 => '$host.vars.services.load.wload15$',
      load_cload1  => '$host.vars.services.load.cload1$',
      load_cload5  => '$host.vars.services.load.cload5$',
      load_cload15 => '$host.vars.services.load.cload15$',
    },
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
