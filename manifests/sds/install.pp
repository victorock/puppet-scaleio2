# the installation part
class scaleio2::sds::install {
  notify  { "scaleio2::sds::install->start": }
  package { "scaleio2::sds::install":
    name => "EMC-ScaleIO-sds",
  }
  notify  { "scaleio2::sds::install->end": }
}
