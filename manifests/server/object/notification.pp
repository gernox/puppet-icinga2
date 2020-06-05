# @summary
#   Setting up the notification objects
#
class gernox_icinga2::server::object::notification (
  String $notification_group,
) {
  ::icinga2::object::notification { 'apply-mail-service-notification':
    import       => [ 'mail-service-notification' ],
    apply        => true,
    apply_target => 'Service',
    user_groups  => [ $notification_group ],
    assign       => [
      'host.vars.notification.email == true',
    ],
    target       => "${::icinga2::globals::conf_dir}/conf.d/notifications.conf",
  }

  ::icinga2::object::notification { 'apply-mail-host-notification':
    import       => [ 'mail-host-notification' ],
    apply        => true,
    apply_target => 'Host',
    user_groups  => [ $notification_group ],
    assign       => [
      'host.vars.notification.email == true',
    ],
    target       => "${::icinga2::globals::conf_dir}/conf.d/notifications.conf",
  }

  ::icinga2::object::notification { 'mail-service':
    apply        => true,
    apply_target => 'Service',
    assign       => [
      'true == true',
    ],
    command      => 'mail-service-notification',
    user_groups  => [ $notification_group ],
    states       => [ 'OK', 'Warning', 'Critical' ],
    types        => [ 'Problem', 'Acknowledgement', 'Recovery', 'Custom' ],
    period       => '24x7',
    target       => "${::icinga2::globals::conf_dir}/conf.d/notifications.conf"
  }

  ::icinga2::object::notification { 'slack-service':
    import       => [ 'slack-service-notification' ],
    apply        => true,
    apply_target => 'Service',
    users        => [ 'gernox-admin' ],
    assign       => [
      'host.vars.notification.slack == true',
    ],
    command      => 'slack-service-notification',
    target       => "${::icinga2::globals::conf_dir}/conf.d/notifications.conf"
  }

  ::icinga2::object::notification { 'slack-host':
    import       => [ 'slack-host-notification' ],
    apply        => true,
    apply_target => 'Host',
    users        => [ 'gernox-admin' ],
    assign       => [
      'host.vars.notification.slack == true',
    ],
    target       => "${::icinga2::globals::conf_dir}/conf.d/notifications.conf"
  }
}
