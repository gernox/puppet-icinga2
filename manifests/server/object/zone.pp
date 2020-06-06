class gernox_icinga2::server::object::zone (
  String $api_host  = $gernox_icinga2::api_host,
  Integer $api_port = $gernox_icinga2::api_port,
  String $zone      = $gernox_icinga2::zone,
) {
  # Master zone
  ::icinga2::object::zone { $zone:
    endpoints => [ $zone ],
  }

  ::icinga2::object::endpoint { $zone:
    host => $api_host,
    port => $api_port,
  }

  file { "/etc/icinga2/zones.d/${zone}":
    ensure  => directory,
    owner   => nagios,
    group   => nagios,
    recurse => true,
    purge   => true,
  }


  # Child Zones
  # Ignore puppetdb during bootstrap
  $nodes = $::settings::storeconfigs ? {
    true    => puppetdb_query(
      "resources { type = 'Class' and title = 'Gernox_icinga2' }"
    ),
    default => {}
  }

  each($nodes) |$node| {
    $node_params = $node['parameters']

    if ($node_params['zone'] != undef) and ($node_params['zone'] != $zone) {

      ::icinga2::object::zone { $node_params['zone']:
        endpoints => [ $node_params['zone'] ],
        parent    => ($node_params['parent_zone'] == undef) ? {
          true    => undef,
          default => $node_params['parent_zone'],
        }
      }

      ::icinga2::object::endpoint { $node_params['zone']:
        host => $node_params['api_host'],
        port => $node_params['api_port'],
      }

      file { "${::icinga2::globals::conf_dir}/zones.d/${node_params['zone']}":
        ensure  => directory,
        owner   => nagios,
        group   => nagios,
        recurse => true,
        purge   => true,
      }
    }
  }
}
