class gernox_icinga2::common::object::applies::tcp {
  ::icinga2::object::service { 'tcp':
    import        => [ 'generic-service' ],
    apply         => 'identifier => config in host.vars.services.tcp',
    display_name  => 'tcp',
    check_command => 'tcp',
    vars          => 'vars + config',
    target        => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
