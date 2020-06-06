# @summary
#   Installs an Icinga2 server
#
# @param api_user
#
# @param api_password
#
# @param notification_group
#
# @param notification_email
#
# @param notification_slack_webhook_url
#
# @param notification_slack_channel
#
# @param notification_slack_bot_name
#
# @param notification_slack_icinga_host
#
# @param notification_users
#
# @param notification_groups
#
class gernox_icinga2::server (
  String $api_user,
  String $api_password,

  String $notification_group,
  String $notification_email,
  String $notification_slack_channel,
  String $notification_slack_bot_name,

  Hash $notification_users,
  Hash $notification_groups,

  String $notification_slack_icinga_host = $::fqdn,
  Optional[String] $notification_slack_webhook_url = undef,
) {
  File {
    owner => 'nagios',
    group => 'nagios',
  }

  contain ::gernox_icinga2::common::install
  contain ::gernox_icinga2::server::install

  contain ::gernox_icinga2::common::features
  contain ::gernox_icinga2::server::features

  contain ::gernox_icinga2::common::object
  contain ::gernox_icinga2::server::object
}
