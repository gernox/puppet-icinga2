class gernox_icinga2::server::install (
  String $db_user     = $gernox_icinga2::server::db_user,
  String $db_password = $gernox_icinga2::server::db_password,
  String $db_name     = $gernox_icinga2::server::db_name,
  Integer $db_port    = $gernox_icinga2::server::db_port,
) {
  class { '::gernox_icinga2::server::feature::ido_pgsql':
    user     => $db_user,
    password => $db_password,
    database => $db_name,
    port     => $db_port,
  }
}
