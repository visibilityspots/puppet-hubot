# Class: hubot::service
#
# Class which manages the hubot service
class hubot::service {
  $packages = [ 'redis', 'hubot' ]
  service { $packages:
    ensure => 'running',
    enable => true,
  }
}
