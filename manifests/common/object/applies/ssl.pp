class gernox_icinga2::common::object::applies::ssl {
  ::icinga2::object::service { 'ssl':
    import        => [ 'daily-service' ],
    apply         => 'identifier => config in host.vars.services.ssl',
    display_name  => 'SSL',
    check_command => 'ssl',
    vars          => 'vars + config',
    target        => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
