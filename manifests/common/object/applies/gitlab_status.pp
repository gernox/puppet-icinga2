class gernox_icinga2::common::object::applies::gitlab_status {
  ::icinga2::object::service { 'gitlab_status':
    apply         => true,
    import        => [ 'generic-service' ],
    display_name  => 'GitLab',
    check_command => 'gitlab_status',
    vars          => {
      gitlab_health_url => '$host.vars.services.gitlab.health_check_url$',
    },
    assign        => [
      'host.vars.services.gitlab',
    ],
    target        => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
