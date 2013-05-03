# Class: hubot::config
#
# Class which configures the hubot agent service
class hubot::config {
  user { $hubot::user:
    ensure     => present,
    managehome => true,
  }

  file { $hubot::root_dir:
    ensure  => 'directory',
    notify  => Exec['Initialize hubot']
  }

  exec { 'Initialize hubot':
    command     => "hubot -c ${hubot::root_dir}",
    refreshonly => true,
    logoutput   => true,
    user        => 'root',
    require     => [
      Package[$hubot::pkg_name],
      File[$hubot::root_dir]
    ]
  }

  file { "${hubot::root_dir}/hubot.env":
    ensure  => 'present',
    content => template('hubot/hubot.env.erb'),
  }

  file { '/etc/init.d/hubot':
    ensure  => 'present',
    content => template('hubot/hubot.erb'),
    mode    => '0755',
    require => File["${hubot::root_dir}/hubot.env"],
    notify  => Service['hubot']
  }


  file { "${hubot::root_dir}/${hubot::executable}":
    mode        => '0755',
    require     => Exec['Initialize hubot'],
    notify      => Exec['Remove redis']
  }

  exec { 'Remove redis':
    command     => "sed -i 's/\"redis-brain.coffee\", //g' ${hubot::root_dir}/hubot-scripts.json",
    require     => Exec['Initialize hubot'],
    refreshonly => true,
    notify      => Exec['Initialize adapter']
  }


  exec { 'Initialize adapter':
    command     => "sed -i '/\"hubot-scripts\"/i \\    \"hubot-${hubot::adapter}\":     \">= 0.0.1\",' ${hubot::root_dir}/package.json",
    onlyif      => 'test `cat package.json | grep hubot-irc | wc -l` -le 0',
    refreshonly => true,
    require     => Exec['Initialize hubot'],
    notify      => Exec['NPM update']
  }

  exec { 'NPM update':
    command     => 'npm update',
    cwd         => $hubot::root_dir,
    refreshonly => true,
    require     => Exec['Initialize hubot'],
    notify      => Service['hubot']
  }
}
