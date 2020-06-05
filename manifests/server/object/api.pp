# @summary
#   Configuration of the Icinga2 API
#
# @param api_user
#
# @param api_password
#
class gernox_icinga2::server::object::api (
  String $api_user     = $gernox_icinga2::server::api_user,
  String $api_password = $gernox_icinga2::server::api_password,
) {
  ::icinga2::object::apiuser { $api_user:
    password    => $api_password,
    permissions => [ '*' ],
    target      => "${::icinga2::globals::conf_dir}/conf.d/apiusers.conf"
  }
}
