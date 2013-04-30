# Class: hubot
#
# Initialization class for the hubot bot
class hubot (
  $dependency_pkgs  = $hubot::params::dependency_pkgs,
  $pkg_name         = $hubot::params::pkg_name,
  $root_dir         = $hubot::params::root_dir,
  $user             = $hubot::params::user,
  $executable       = $hubot::params::executable,

  $log_file         = $hubot::params::log_file,
  $log_level        = $hubot::params::log_level,

  $adapter          = $hubot::params::adapter,
  $irc_nickname     = $hubot::params::irc_nickname,
  $irc_server       = $hubot::params::irc_server,
  $irc_rooms        = $hubot::params::irc_server,
  $irc_debug        = $hubot::params::irc_debug,
  $irc_unflood      = $hubot::params::irc_unflood,

) inherits hubot::params {

  include hubot::install
  include hubot::config
  include hubot::service

  motd::register{'hubot': }

  Class['hubot::install'] ->
  Class['hubot::config'] ->
  Class['hubot::service']
}
