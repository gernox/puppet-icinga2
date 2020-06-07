# @summary
#   Main manifest for common icinga objects
#
# @param fqdn
#
class gernox_icinga2::common::object (
  String $fqdn = $::fqdn,
  String $type = $gernox_icinga2::type,
) {
  contain ::gernox_icinga2::common::object::checkcommand
  contain ::gernox_icinga2::common::object::template
  contain ::gernox_icinga2::common::object::hostgroup
  contain ::gernox_icinga2::common::object::servicegroup
  contain ::gernox_icinga2::common::object::service
  contain ::gernox_icinga2::common::object::timeperiod

  contain $::gernox_icinga2::apply_class
  # contain ::gernox_monitoring

  # Hash of local variables from facts
  $local_vars = {
    'os'           => $::kernel,
    'vm'           => $::is_virtual,
    'distro'       => $::operatingsystem,
    'os_codename'  => $::lsbdistcodename,
    'notification' => {
      'email' => $::gernox_icinga2::enable_email,
      'slack' => $::gernox_icinga2::enable_slack,
    }
  }

  # lint:ignore:variable_scope
  $ress_vars = $::settings::storeconfigs ? {
    true    => puppetdb_query(
      "resources { type = 'Gernox_icinga2::Monitoring_parameters' and certname = '${fqdn}' }"
    ),
    default => {}
  }
  # lint:endignore

  # Merging parameters with the same name
  #  processes:
  #   apache:
  #    procname: apache2
  #   icinga:
  #    procname: icinga2

  # lint:ignore:variable_scope
  $merge = $ress_vars.reduce({}) |$value, $mon_param| {
    deep_merge($value, $mon_param['parameters']['vars'])
  }
  # lint:endignore

  # Merging all monitoring_vars from
  #   - local (defined here)
  #   - exporterd vars in PuppetDB
  #   - Hiera (node/role/etc)

  $exported_vars = deep_merge($local_vars, $merge)

  # TODO: What happens here?
  if $::gernox_icinga2::parent_zone {

    $parent_vars = deep_merge($exported_vars, {
      'parent' => $::gernox_icinga2::parent_zone,
    })

  } else {
    $parent_vars = $exported_vars
  }

  $vars = deep_merge($parent_vars, $::gernox_icinga2::vars)

  ::gernox_icinga2::common::object::host { $fqdn:
    target       => "/etc/icinga2/conf.d/${fqdn}.conf",
    display_name => $fqdn,
    address      => $::gernox_icinga2::address,
    vars         => $vars,
  }

  # TODO can probably be removed?
  if ($type == 'server') {
    ::icinga2::object::zone { 'global-templates':
      global => true,
    }

    file { "${::icinga2::globals::conf_dir}/zones.d/global-templates":
      ensure  => directory,
      owner   => nagios,
      group   => nagios,
      recurse => true,
      purge   => true,
    }
  }
}
