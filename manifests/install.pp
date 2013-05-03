# Class: hubot::install
#
# Installation of the hubot npm software
class hubot::install {
  package { $hubot::dependency_pkgs:
    ensure   => 'installed',
    provider => 'npm',
    require  => Package['nodejs']
  }

  package { $hubot::pkg_name:
    ensure   => 'installed',
    provider => 'npm',
    notify   => Exec['Initialize hubot'],
    require  => Package[$hubot::dependency_pkgs]
  }
}
