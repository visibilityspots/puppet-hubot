# Class: hubot::service
#
# Class which manages the hubot service
class hubot::service {
  service {'hubot':
    ensure   => 'running',
    enable   => true,
    require  => File['/etc/init.d/hubot']
  }
}
