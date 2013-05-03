# Class: hubot::service
#
# Class which manages the hubot service
class hubot::service {
  service {'hubot':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    require    => File['/etc/init.d/hubot'],
    subscribe  => File["${hubot::root_dir}/hubot.env"]
  }
}
