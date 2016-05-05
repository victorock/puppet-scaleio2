class scaleio2::mdm::config::cluster::rename {
  $cluster_name     = $scaleio2::mdm::config::cluster::cluster_name

  notify { "scaleio2::mdm::config::cluster::rename->start": }

  exec { 'scaleio2::mdm::config::cluster::rename':
    command => "scli --rename_system --new_name '${cluster_name}'",
    path => ["/usr/bin", "/sbin", "/bin"],
    unless  => "scli --query_cluster 2> /dev/null | grep 'Name: ${cluster_name}'",
    require => Class['::scaleio2::mdm::config::login'],
  }

  notify { "scaleio2::mdm::config::cluster::rename->end": }
}
