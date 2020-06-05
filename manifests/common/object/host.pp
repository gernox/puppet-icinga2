# @summary
#   Wrapped icinga host
define gernox_icinga2::common::object::host (
  $target,
  $ensure                = present,
  $host_name             = $title,
  $address               = undef,
  $address6              = undef,
  $vars                  = undef,
  $groups                = undef,
  $display_name          = undef,
  $check_command         = undef,
  $max_check_attempts    = undef,
  $check_period          = undef,
  $check_timeout         = undef,
  $check_interval        = undef,
  $retry_interval        = undef,
  $enable_notifications  = undef,
  $enable_active_checks  = true,
  $enable_passive_checks = true,
  $enable_event_handler  = true,
  $enable_flapping       = undef,
  $enable_perfdata       = true,
  $event_command         = undef,
  $flapping_threshold    = undef,
  $volatile              = undef,
  $zone                  = undef,
  $command_endpoint      = undef,
  $notes                 = undef,
  $notes_url             = undef,
  $action_url            = undef,
  $icon_image            = undef,
  $icon_image_alt        = undef,
  $template              = false,
  $order                 = '50',
) {
}
