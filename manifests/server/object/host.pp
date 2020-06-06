class gernox_icinga2::server::object::host {
  # Ignore puppetdb during bootstrap
  $hosts = $::settings::storeconfigs ? {
    # collect all hosts that have been exported
    true    => puppetdb_query(
      "resources { type = 'Gernox_icinga2::Common::Object::Host' }"
    ),
    default => {}
  }

  each($hosts) |$host| {
    $host_params = $host['parameters']

    $overwrite_vars = {
      'remote_client' => $host['title'],
    }
    $vars = merge($host_params['vars'], $overwrite_vars)

    ::icinga2::object::host { $host['title']:
      ensure                  => $host_params['ensure'],
      host_name               => $host_params['host_name'],
      import                  => [ 'generic-host' ],
      address                 => $host_params['address'],
      address6                => $host_params['address6'],
      vars                    => $vars,
      groups                  => $host_params['groups'],
      display_name            => $host_params['display_name'],
      check_command           => $host_params['check_command'],
      max_check_attempts      => $host_params['max_check_attempts'],
      check_period            => $host_params['check_period'],
      check_timeout           => $host_params['check_timeout'],
      check_interval          => $host_params['check_interval'],
      retry_interval          => $host_params['retry_interval'],
      enable_notifications    => $host_params['enable_notifications'],
      enable_active_checks    => $host_params['enable_active_checks'],
      enable_passive_checks   => $host_params['enable_passive_checks'],
      enable_event_handler    => $host_params['enable_event_handler'],
      enable_flapping         => $host_params['enable_flapping'],
      enable_perfdata         => $host_params['enable_perfdata'],
      event_command           => $host_params['event_command'],
      flapping_threshold_low  => $host_params['flapping_threshold_low'],
      flapping_threshold_high => $host_params['flapping_threshold_high'],
      volatile                => $host_params['volatile'],
      zone                    => $host_params['zone'],
      #command_endpoint      => $host['title'],
      notes                   => $host_params['notes'],
      notes_url               => $host_params['notes_url'],
      action_url              => $host_params['action_url'],
      icon_image              => $host_params['icon_image'],
      icon_image_alt          => $host_params['icon_image_alt'],
      template                => $host_params['template'],
      order                   => '50',
      #target                => "${::icinga2::globals::conf_dir}/zones.d/${host['title']}/hosts.conf",
      #target                => "${::icinga2::globals::conf_dir}/conf.d/hosts.conf",
      #target                => "${::icinga2::globals::conf_dir}/zones.d/global-templates/hosts.conf",
      target                  => ($vars['parent'] == undef) ? {
        true    => "${::icinga2::globals::conf_dir}/zones.d/${host['title']}/hosts.conf",
        default => "${::icinga2::globals::conf_dir}/zones.d/${vars['parent']}/hosts.conf",
      },
      require                 => ($vars['parent'] == undef) ? {
        true    => undef,
        default => File["${::icinga2::globals::conf_dir}/zones.d/${vars['parent']}"],
      }
    }
  }
}
