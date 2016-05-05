# the installation part
class scaleio2::mdm::service {

  notify { "::scaleio2::mdm::service->start": } ->
  service { '::scaleio2::mdm::service':
    name      => "mdm",
    ensure    => running,
    enable    => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe => File['/opt/emc/mdm/cfg/conf.txt'],
  } ->
  notify { "::scaleio2::mdm::service:start": }
}
