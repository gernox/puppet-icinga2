# @summary
#   Main manifest for common Icinga features
#
class gernox_icinga2::common::features {
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
