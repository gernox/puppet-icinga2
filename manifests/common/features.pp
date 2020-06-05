# @summary
#   Main manifest for common Icinga features
#
# @param pki_ca_name
#
# @param pki_path
#
# @param fqdn
#
class gernox_icinga2::common::features (
  String $pki_ca_name,
  String $pki_path,
  String $fqdn = $::fqdn,
) {
  contain ::icinga2::feature::checker
  contain ::icinga2::feature::mainlog

  class { '::icinga2::feature::api':
    accept_config   => true,
    accept_commands => true,
    pki             => 'puppet',
    endpoints       => {},
    zones           => {},
  }
}
