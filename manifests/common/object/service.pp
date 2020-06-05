# @summary
#   Configuration for services
#
class gernox_icinga2::common::object::service {
  ::icinga2::object::service { 'daily-service':
    template       => true,
    check_interval => '24h',
    target         => "${::icinga2::globals::conf_dir}/conf.d/services.conf"
  }

  ::icinga2::object::service { 'hourly-service':
    template       => true,
    check_interval => '1h',
    target         => "${::icinga2::globals::conf_dir}/conf.d/services.conf"
  }
}
