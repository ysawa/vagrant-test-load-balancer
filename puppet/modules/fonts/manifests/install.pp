class fonts::install {
  $packages = [
    'fonts-ipaexfont',
    'fonts-ipaexfont-gothic',
    'fonts-ipaexfont-mincho',
    'fonts-ipafont',
    'fonts-ipamj-mincho',
  ]

  package { $packages:
    ensure => installed
  }
}
