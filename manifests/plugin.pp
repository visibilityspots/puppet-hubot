# Define: hubot::plugin
#
# Define which installs a hubot plugin
define hubot::plugin{
  exec { "Install ${name} plugin":
    command  => "./plugin.sh ${name}",
    cwd      => $hubot::root_dir,
    provider => shell,
    onlyif   => "test `cat hubot-scripts.json | grep ${name} | wc -l` -le 0",
    require  => File["${hubot::root_dir}/plugin.sh"],
    notify   => Exec['NPM update']
  }
}
