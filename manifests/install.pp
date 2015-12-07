# Class: hubot::install
#
# Installation of the hubot service
class hubot::install {
  $packages = [ 'redis', 'hubot' ]
  package { $packages:
    ensure   => 'installed',
  }
}
