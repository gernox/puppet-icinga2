class gernox_icinga2::server::object::notificationcommand (
  String $notification_slack_icinga_host = $::gernox_icinga2::server::notification_slack_icinga_host,
  Optional[String] $notification_slack_webhook_url = $::gernox_icinga2::server::notification_slack_webhook_url,
  String $notification_slack_channel     = $::gernox_icinga2::server::notification_slack_channel,
  String $notification_slack_bot_name    = $::gernox_icinga2::server::notification_slack_bot_name,
) {
  ::icinga2::object::notificationcommand { 'mail-service-notification':
    command => [ '/etc/icinga2/scripts/mail-service-notification.sh' ],
    env     => {
      'NOTIFICATIONTYPE'       => '$notification.type$',
      'SERVICEDESC'            => '$service.name$',
      'HOSTALIAS'              => '$host.display_name$',
      'SERVICENAME'            => '$service.name$',
      'HOSTNAME'               => '$host.name$',
      'HOSTDISPLAYNAME'        => '$host.display_name$',
      'HOSTADDDRESS'           => '$address$',
      'SERVICESTATE'           => '$service.state$',
      'LONGDATETIME'           => '$icinga.long_date_time$',
      'SERVICEOUTPUT'          => '$service.output$',
      'SERVICEDISPLAYNAME'     => '$service.display_name$',
      'NOTIFICATIONAUTHORNAME' => '$notification.author$',
      'NOTIFICATIONCOMMENT'    => '$notification.comment$',
      'HOSTDISPLAYNAME'        => '$host.display_name$',
      'USEREMAIL'              => '$user.email$',
    },
    target  => "${::icinga2::globals::conf_dir}/conf.d/notificationcommands.conf",
  }

  ::icinga2::object::notificationcommand { 'mail-host-notification':
    command => [ '/etc/icinga2/scripts/mail-host-notification.sh' ],
    env     => {
      'NOTIFICATIONTYPE'       => '$notification.type$',
      'HOSTNAME'               => '$host.name$',
      'HOSTDISPLAYNAME'        => '$host.display_name$',
      'HOSTADDRESS'            => '$address$',
      'HOSTSTATE'              => '$host.state$',
      'LONGDATETIME'           => '$icinga.long_date_time$',
      'HOSTOUTPUT'             => '$host.output$',
      'NOTIFICATIONAUTHORNAME' => '$notification.author$',
      'NOTIFICATIONCOMMENT'    => '$notification.comment$',
      'HOSTDISPLAYNAME'        => '$host.display_name$',
      'USEREMAIL'              => '$user.email$',
    },
    target  => "${::icinga2::globals::conf_dir}/conf.d/notificationcommands.conf",
  }

  file { '/etc/icinga2/scripts/slack-service-notification.sh':
    mode    => '0755',
    content => template('gernox_icinga2/notifications/slack-service-notification.sh.erb'),
  }

  file { '/etc/icinga2/scripts/slack-host-notification.sh':
    mode    => '0755',
    content => template('gernox_icinga2/notifications/slack-host-notification.sh.erb'),
  }

  ::icinga2::object::notificationcommand { 'slack-service-notification':
    command => [ '/etc/icinga2/scripts/slack-service-notification.sh' ],
    env     => {
      'NOTIFICATIONTYPE'       => '$notification.type$',
      'SERVICEDESC'            => '$service.name$',
      'HOSTALIAS'              => '$host.display_name$',
      'HOSTNAME'               => '$host.name$',
      'HOSTADDRESS'            => '$address$',
      'SERVICESTATE'           => '$service.state$',
      'LONGDATETIME'           => '$icinga.long_date_time$',
      'SERVICEOUTPUT'          => '$service.output$',
      'NOTIFICATIONAUTHORNAME' => '$notification.author$',
      'NOTIFICATIONCOMMENT'    => '$notification.comment$',
      'HOSTDISPLAYNAME'        => '$host.display_name$',
      'SERVICEDISPLAYNAME'     => '$service.display_name$',
    },
    target  => "${::icinga2::globals::conf_dir}/conf.d/notificationcommands.conf",
  }

  ::icinga2::object::notificationcommand { 'slack-host-notification':
    command => [ '/etc/icinga2/scripts/slack-host-notification.sh' ],
    env     => {
      'NOTIFICATIONTYPE'       => '$notification.type$',
      'HOSTALIAS'              => '$host.display_name$',
      'HOSTADDRESS'            => '$address$',
      'HOSTSTATE'              => '$host.state$',
      'LONGDATETIME'           => '$icinga.long_date_time$',
      'HOSTOUTPUT'             => '$host.output$',
      'NOTIFICATIONAUTHORNAME' => '$notification.author$',
      'NOTIFICATIONCOMMENT'    => '$notification.comment$',
      'HOSTDISPLAYNAME'        => '$host.display_name$',
      'USEREMAIL'              => '$user.email$',
    },
    target  => "${::icinga2::globals::conf_dir}/conf.d/notificationcommands.conf",
  }
}
