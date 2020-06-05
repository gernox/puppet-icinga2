class gernox_icinga2::common::object::applies::http {
  ::icinga2::object::service { 'http':
    import        => [ 'generic-service' ],
    apply         => 'identifier => config in host.vars.services.http',
    display_name  => 'http',
    check_command => 'http',
    vars          => 'vars + config',
    target        => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
