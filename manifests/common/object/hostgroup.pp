# @summary
#   Configuration for hostgroups
#
class gernox_icinga2::common::object::hostgroup {
  ::icinga2::object::hostgroup { 'linux-servers':
    display_name => 'Linux Servers',
    assign       => [
      'host.vars.os == Linux',
    ],
    target       => "${::icinga2::globals::conf_dir}/conf.d/hostgroups.conf"
  }
}
