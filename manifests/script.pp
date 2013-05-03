# Class: hubot::script
#
# Class which configures the declared scripts
class hubot::script {

#  exec { 'Remove redis':
#    command     => "sed -i 's/\"redis-brain.coffee\", //g' ${hubot::root_dir}/hubot-scripts.json",
#    require     => Exec['Initialize hubot'],
#    refreshonly => true,
#    notify      => Exec['Add adapter']
#  }
#
#  exec { 'Add adapter':
#    command     => "sed -i '/\"hubot-scripts\"/i \\    \"hubot-irc\":     \">= 0.0.6\",' ${hubot::root_dir}/package.json",
#    onlyif      => 'test `cat package.json | grep hubot-irc | wc -l` -le 0',
#    refreshonly => true,
#    require     => Exec['Initialize hubot'],
#    notify      => Exec['NPM update']
#  }
#
#  exec { 'NPM update':
#    command => "cd ${hubot::root_dir}; npm update",
#    require => Exec['Initialize hubot'],
#    File["${hubot::root_dir}/hubot.env"]
#    notify  => Service['hubot']
#  }
#
#  }
}
