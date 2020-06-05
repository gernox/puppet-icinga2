class gernox_icinga2::common::object::applies::users {
  ::icinga2::object::service { 'users':
    apply            => true,
    import           => [ 'generic-service' ],
    check_command    => 'users',
    command_endpoint => 'host.vars.remote_client',
    assign           => [
      'host.vars.remote_client && linux-servers in host.groups && host.vars.services.users',
    ],
    vars             => {
      users_wgreater => '$host.vars.services.users.warning$',
      users_cgreater => '$host.vars.services.users.critical$'
    },
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
