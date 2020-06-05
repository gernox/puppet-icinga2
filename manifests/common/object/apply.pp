# @summary
#   Main manifest for all applies
#
class gernox_icinga2::common::object::apply {
  contain ::gernox_icinga2::common::object::applies::apt
  contain ::gernox_icinga2::common::object::applies::bareos
  contain ::gernox_icinga2::common::object::applies::disk
  contain ::gernox_icinga2::common::object::applies::gitlab_status
  contain ::gernox_icinga2::common::object::applies::http
  contain ::gernox_icinga2::common::object::applies::icinga
  contain ::gernox_icinga2::common::object::applies::ldap
  contain ::gernox_icinga2::common::object::applies::load
  contain ::gernox_icinga2::common::object::applies::mailq
  contain ::gernox_icinga2::common::object::applies::ntp
  contain ::gernox_icinga2::common::object::applies::ping
  contain ::gernox_icinga2::common::object::applies::procs
  contain ::gernox_icinga2::common::object::applies::puppet
  contain ::gernox_icinga2::common::object::applies::rabbitmq
  contain ::gernox_icinga2::common::object::applies::reboot_required
  contain ::gernox_icinga2::common::object::applies::smart
  contain ::gernox_icinga2::common::object::applies::ssh
  contain ::gernox_icinga2::common::object::applies::ssl
  contain ::gernox_icinga2::common::object::applies::swap
  contain ::gernox_icinga2::common::object::applies::systemd
  contain ::gernox_icinga2::common::object::applies::tcp
  contain ::gernox_icinga2::common::object::applies::users
}
