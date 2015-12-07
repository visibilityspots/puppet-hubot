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

  }


}
