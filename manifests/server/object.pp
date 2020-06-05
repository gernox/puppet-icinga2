class gernox_icinga2::server::object {
  contain ::gernox_icinga2::server::object::api
  contain ::gernox_icinga2::server::object::host
  contain ::gernox_icinga2::server::object::user
  contain ::gernox_icinga2::server::object::usergroup
  contain ::gernox_icinga2::server::object::zone
  contain ::gernox_icinga2::server::object::dependency

  contain ::gernox_icinga2::server::object::notification
  contain ::gernox_icinga2::server::object::notificationcommand
}
