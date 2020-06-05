# @summary
#   Configuration of templates
#
class gernox_icinga2::common::object::template {
  ::icinga2::object::host { 'generic-host':
    template           => true,
    check_command      => 'hostalive',
    max_check_attempts => 3,
    check_interval     => '10m',
    retry_interval     => '5m',
    target             => "${::icinga2::globals::conf_dir}/conf.d/templates.conf",
  }

  ::icinga2::object::service { 'generic-service':
    template           => true,
    max_check_attempts => 5,
    check_interval     => '10m',
    retry_interval     => '3m',
    target             => "${::icinga2::globals::conf_dir}/conf.d/templates.conf",
  }

  ::icinga2::object::user { 'generic-user':
    template => true,
    target   => "${::icinga2::globals::conf_dir}/conf.d/templates.conf",
  }

  ::icinga2::object::notification { 'mail-host-notification':
    template => true,
    command  => 'mail-host-notification',
    states   => [
      'Up',
      'Down',
    ],
    types    => [
      'Problem',
      'Acknowledgement',
      'Recovery',
      'Custom',
      'DowntimeStart',
      'DowntimeEnd',
      'DowntimeRemoved',
    ],
    period   => '24x7',
    target   => "${::icinga2::globals::conf_dir}/conf.d/templates.conf",
  }

  ::icinga2::object::notification { 'mail-service-notification':
    template => true,
    command  => 'mail-service-notification',
    states   => [
      'OK',
      'Warning',
      'Critical',
      'Unknown',
    ],
    types    => [
      'Problem',
      'Acknowledgement',
      'Recovery',
      'Custom',
      'DowntimeStart',
      'DowntimeEnd',
      'DowntimeRemoved',
    ],
    period   => '24x7',
    target   => "${::icinga2::globals::conf_dir}/conf.d/templates.conf",
  }

  ::icinga2::object::notification { 'slack-host-notification':
    template => true,
    command  => 'slack-host-notification',
    states   => [
      'Up',
      'Down',
    ],
    types    => [
      'Problem',
      'Acknowledgement',
      'Recovery',
      'Custom',
      'DowntimeStart',
      'DowntimeEnd',
      'DowntimeRemoved',
    ],
    period   => '24x7',
    interval => '1800',
    target   => "${::icinga2::globals::conf_dir}/conf.d/templates.conf",
  }

  ::icinga2::object::notification { 'slack-service-notification':
    template => true,
    command  => 'slack-service-notification',
    states   => [
      'OK',
      'Warning',
      'Critical',
      'Unknown',
    ],
    types    => [
      'Problem',
      'Acknowledgement',
      'Recovery',
      'Custom',
      'DowntimeStart',
      'DowntimeEnd',
      'DowntimeRemoved',
    ],
    period   => '24x7',
    interval => '1800',
    target   => "${::icinga2::globals::conf_dir}/conf.d/templates.conf",
  }
}
