# @summary
#   Installs the common client features, objects and child and parent zones
#
# @param zone
#   Name of child zone
#
# @param api_host
#
# @param api_port
#
# @param parent_zone
#   Name of parent zone
#
class gernox_icinga2::client (
  String $zone                  = $gernox_icinga2::zone,
  String $api_host              = $gernox_icinga2::api_host,
  Integer $api_port             = $gernox_icinga2::api_port,
  Optional[String] $parent_zone = $gernox_icinga2::parent_zone,
) {
  contain ::gernox_icinga2::common::install
  contain ::gernox_icinga2::common::features
  contain ::gernox_icinga2::common::object

  # Client zond and endpoint
  ::icinga2::object::zone { $zone:
    parent    => $parent_zone,
    endpoints => [ $zone ],
  }

  ::icinga2::object::endpoint { $zone:
    host => $api_host,
    port => $api_port,
  }

  # Parent zone
  # Ignore puppetdb during bootstrap
  $parent_nodes = $::settings::storeconfigs ? {
    true    => puppetdb_query(
      "resources { type = 'Class' and title = 'Gernox_icinga2' and parameters.zone = '${parent_zone}' }"
    ),
    default => {}
  }

  # Create zone for each parent
  each($parent_nodes) |$parent_node| {
    $parent_params = $parent_node['parameters']

    ::icinga2::object::zone { $parent_node['certname']:
      endpoints => [ $parent_node['certname'] ]
    }

    ::icinga2::object::endpoint { $parent_node['certname']:
      host => $parent_params['api_host'],
      port => $parent_params['api_port'],
    }
  }

  # Child zones
  # Ignore puppetdb during bootstrap
  $child_nodes = $::settings::storeconfigs ? {
    true    => puppetdb_query(
      "resources { type = 'Class' and title = 'Gernox_icinga2' and parameters.zone = '${zone}' }"
    ),
    default => {}
  }

  # Create zone for each child
  each($child_nodes) |$child_node| {
    $child_params = $child_node['parameters']

    if (!defined(::Icinga2::Object::Zone[$child_node['certname']])) {
      ::icinga2::object::zone { $child_node['certname']:
        parent    => $zone,
        endpoints => [ $child_node['certname'] ]
      }

      ::icinga2::object::endpoint { $child_node['certname']:
        host => $child_params['api_host'],
        port => $child_params['api_port'],
      }
    }
  }
}
