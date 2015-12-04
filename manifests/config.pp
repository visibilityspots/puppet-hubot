# Class: hubot::config
#
# Class which configures the hubot daemon
class hubot::config {

  case $::service_provider {
    'systemd': {
      # that file is provided by .rpm hubot package
      file { '/etc/systemd/system/hubot.service.d/hubot.conf':
        ensure  => 'present',
        content => template('hubot/hubot.conf.erb'),
        notify  => [ Exec['hubot-systemctl-daemon-reload'], Service['hubot'] ],
      }
      exec { 'hubot-systemctl-daemon-reload':
        path        => $::path,
        command     => 'systemctl daemon-reload',
        refreshonly => true,
      }
    }

    default: {
    }

  }

}
