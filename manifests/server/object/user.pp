class gernox_icinga2::server::object::user (
  Hash $groups               = $gernox_icinga2::server::notification_groups,
  Hash $users                = $gernox_icinga2::server::notification_users,
  String $notification_email = $gernox_icinga2::server::notification_email,
  String $notification_group = $gernox_icinga2::server::notification_group,
) {
  ::icinga2::object::user { 'gernox-admin':
    import       => ['generic-user'],
    display_name => 'GerNOX Admin',
    email        => $notification_email,
    groups       => [
      $notification_group,
    ],
    target       => "${::icinga2::globals::conf_dir}/conf.d/users.conf"
  }
}
