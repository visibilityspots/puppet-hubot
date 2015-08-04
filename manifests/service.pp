# Class: hubot::service
#
# Class which manages the hubot service
class hubot::service {
  service { 'hubot':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
  }
}
