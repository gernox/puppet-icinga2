class gernox_icinga2::server::object::usergroup (
  String $notification_group = $gernox_icinga2::server::notification_group,
) {
  ::icinga2::object::usergroup { $notification_group:
    target => "${::icinga2::globals::conf_dir}/conf.d/usergroups.conf"
  }
}
