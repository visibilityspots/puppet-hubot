# Class: hubot::config
#
# Class which configures the hubot daemon
class hubot::config {

  file { '/opt/hubot/hubot.env':
    ensure  => 'present',
    content => template('hubot/hubot.env.erb'),
  }

  file { '/opt/hubot/plugins.env':
    ensure  => 'present',
  }

  exec { 'set_service_adapter':
    command => "sed -i '/^DAEMON_ADAPTER/{c\\DAEMON_ADAPTER=\"${::hubot::adapter}\"'$'\n';d'}' /etc/init.d/hubot",
    unless  => "cat /etc/init.d/hubot | grep ${::hubot::adapter} | grep -v grep"
  }

}
