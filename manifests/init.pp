# @summary
#   Manages Icinga2
#
# @param type
#
# @param zone
#
# @param address
#
# @param api_host
#
# @param api_port
#
# @param vars
#
# @param parent_zone
#
# @param enable_email
#
# @param enable_slack
#
# @param apply_class
#
class gernox_icinga2 (

  Enum['client', 'server'] $type,
  String $zone,

  String $address,

  String $api_host,
  Integer $api_port,

  Hash $vars,

  Boolean $enable_email,
  Boolean $enable_slack,

  String $apply_class,

  Optional[String] $parent_zone = undef,

) {
  File {
    owner => 'nagios',
    group => 'nagios',
  }

  contain "::gernox_icinga2::${type}"

}
