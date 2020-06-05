class gernox_icinga2::common::object::applies::ldap {
  ::icinga2::object::service { 'ldap':
    import           => [ 'generic-service' ],
    apply            => 'identifier => config in host.vars.services.ldap',
    display_name     => 'ldap',
    command_endpoint => 'host.vars.remote_client',
    check_command    => 'ldap',
    vars             => 'vars + config',
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
