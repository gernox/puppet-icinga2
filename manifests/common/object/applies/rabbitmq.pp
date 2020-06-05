class gernox_icinga2::common::object::applies::rabbitmq {
  ::icinga2::object::service { 'rabbitmq_consumers':
    apply            => true,
    import           => ['generic-service'],
    check_command    => 'rabbitmq_consumers',
    command_endpoint => 'host.vars.remote_client',
    vars             => {
      rabbitmq_user     => '$host.vars.services.rabbitmq.user$',
      rabbitmq_password => '$host.vars.services.rabbitmq.password$',
      rabbitmq_url      => '$host.vars.services.rabbitmq_consumers.url$',
      rabbitmq_queue    => '$host.vars.services.rabbitmq_consumers.queue$',
      rabbitmq_critical => '$host.vars.services.rabbitmq_consumers.critical$',
      rabbitmq_warning  => '$host.vars.services.rabbitmq_consumers.warning$',
    },
    assign           => [
      'host.vars.remote_client && host.vars.services.rabbitmq_consumers'
    ],
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }

  ::icinga2::object::service { 'rabbitmq_queuesize':
    apply            => true,
    import           => ['generic-service'],
    check_command    => 'rabbitmq_queusize',
    command_endpoint => 'host.vars.remote_client',
    vars             => {
      rabbitmq_user     => '$host.vars.services.rabbitmq.user$',
      rabbitmq_password => '$host.vars.services.rabbitmq.password$',
      rabbitmq_url      => '$host.vars.services.rabbitmq_queuesize.url$',
      rabbitmq_critical => '$host.vars.services.rabbitmq_queuesize.critical$',
      rabbitmq_warning  => '$host.vars.services.rabbitmq_queuesize.warning$',
    },
    assign           => [
      'host.vars.remote_client && host.vars.services.rabbitmq_queuesize'
    ],
    target           => "${::icinga2::globals::conf_dir}/conf.d/applies.conf",
  }
}
