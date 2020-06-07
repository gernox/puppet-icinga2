# @summary
#   Every check_* needs a checkcommand and its parameters mapped
#
# @param gernox_cmd_path
#
# @param nagios_cmd_path
#
class gernox_icinga2::common::object::checkcommand (
  String $gernox_cmd_path,
  String $nagios_cmd_path,
  String $puppet_last_run_file,
  Array $custom_check_packages = [],
) {

  file { $gernox_cmd_path:
    ensure  => directory,
    recurse => true,
    purge   => true,
    mode    => '1755',
    source  => 'puppet:///modules/gernox_icinga2/checks',
  }

  file { "${gernox_cmd_path}/check_puppet_agent":
    mode    => '0755',
    content => template('gernox_icinga2/checks/check_puppet_agent.erb'),
  }

  ensure_packages($custom_check_packages, {
    ensure => present,
  })

  ::icinga2::object::checkcommand { 'rabbitmq_consumers':
    command   => [ "${gernox_cmd_path}/check_rabbitmq_consumers" ],
    arguments => {
      '-u' => {
        value => '$rabbitmq_user$',
        order => '-6',
      },
      '-p' => {
        value => '$rabbitmq_password$',
        order => '-5',
      },
      '-a' => {
        value => '$rabbitmq_url$',
        order => '-4',
      },
      '-q' => {
        value => '$rabbitmq_queue$',
        order => '-3',
      },
      '-c' => {
        value => '$rabbitmq_critical$',
        order => '-2',
      },
      '-w' => {
        value => '$rabbitmq_warning$',
        order => '-1',
      },
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'rabbitmq_queuesize':
    command   => [ "${gernox_cmd_path}/check_rabbitmq_queuesize" ],
    arguments => {
      '-u' => {
        value => '$rabbitmq_user$',
        order => '-6',
      },
      '-p' => {
        value => '$rabbitmq_password$',
        order => '-5',
      },
      '-a' => {
        value => '$rabbitmq_url$',
        order => '-4',
      },
      '-c' => {
        value => '$rabbitmq_critical$',
        order => '-3',
      },
      '-w' => {
        value => '$rabbitmq_warning$',
        order => '-2',
      },
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'bareos_status':
    command   => [ "${gernox_cmd_path}/check_bareos" ],

    arguments => {
      '--database'     => {
        value => '$bareos_database$',
        order => '-5',
      },
      '--user'         => {
        value => '$bareos_user$',
        order => '-4',
      },
      '--password'     => {
        value => '$bareos_password$',
        order => '-3',
      },
      '--Host'         => {
        value => '$bareos_host$',
        order => '-2',
      },
      '--port'         => {
        value => '$bareos_port$',
        order => '-1',
      },
      'status'         => {
        key   => 'status',
        order => '1',
      },
      '--emptyBackups' => {
        key   => '--emptyBackups',
        order => '2',
      },
      '--full'         => {
        set_if => '$bareos_full$',
        order  => '3',
      },
      '--warning'      => {
        value => '$bareos_warning$',
        order => '3',
      },
      '--critical'     => {
        value => '$bareos_critical$',
        order => '3',
      },
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'bareos_failed':
    command   => [ "${gernox_cmd_path}/check_bareos" ],

    arguments => {
      '--database'      => {
        value => '$bareos_database$',
        order => '-5',
      },
      '--user'          => {
        value => '$bareos_user$',
        order => '-4',
      },
      '--password'      => {
        value => '$bareos_password$',
        order => '-3',
      },
      '--Host'          => {
        value => '$bareos_host$',
        order => '-2',
      },
      '--port'          => {
        value => '$bareos_port$',
        order => '-1',
      },
      'status'          => {
        key   => 'status',
        order => '1',
      },
      '--failedBackups' => {
        key   => '--failedBackups',
        order => '2',
      },
      '--warning'       => {
        value => '$bareos_warning$',
        order => '3',
      },
      '--critical'      => {
        value => '$bareos_critical$',
        order => '3',
      },
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'gitlab_status':
    command   => [ "${gernox_cmd_path}/check_gitlab_status" ],
    arguments => {
      '--pseudo' => {
        skip_key => true,
        value    => '$gitlab_health_url$',
      },
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'gernox_mailq':
    import    => [ 'plugin-check-command' ],
    command   => [ "${nagios_cmd_path}/check_mailq" ],
    arguments => {
      '-w' => '$mailq_warning$',
      '-c' => '$mailq_critical$',
      '-M' => '$mailq_mailserver$',
    },
    vars      => {
      'mailq_warning'    => '3',
      'mailq_critical'   => '5',
      'mailq_mailserver' => 'postfix',
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'puppet_agent':
    command   => [ "${gernox_cmd_path}/check_puppet_agent" ],
    arguments => {
      '-w' => {
        value => '86400', # 24h * 60min * 60sec
      },
      '-c' => {
        value => '172800', # 2 * 24h * 60min * 60sec
      },
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'reboot_required':
    command => ["${gernox_cmd_path}/check_reboot_required"],
    target  => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'smart_status':
    command   => [ '/usr/bin/sudo', "${gernox_cmd_path}/check_smart_attributes" ],
    arguments => {
      '-d'   => {
        value      => '$disks$',
        repeat_key => true,
      },
      '-dbj' => {
        value => "${gernox_cmd_path}/smart/check_smartdb.json",
        order => '-1',
      },
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'systemd_service':
    command   => ["${gernox_cmd_path}/check_systemd_service"],
    arguments => {
      '--pseudo' => {
        skip_key => true,
        value    => '$name$',
      }
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

  ::icinga2::object::checkcommand { 'check_systemd_system':
    command   => ["${gernox_cmd_path}/check_systemd_system"],
    arguments => {
      '--pseudo' => {
        skip_key => true,
        value    => '$name$',
      }
    },
    target    => "${::icinga2::globals::conf_dir}/conf.d/checkcommands.conf",
  }

}
