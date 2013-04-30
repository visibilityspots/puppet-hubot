# Class hubot::params
#
# This class contains every parameter which will be used in this puppet module
# for setting up the hubot bot
class hubot::params {
  $dependency_pkgs  = 'coffee-script'
  $pkg_name         = 'hubot'
  $root_dir         = '/opt/hubot/'
  $user             = 'hubot'
  $executable       = 'bin/hubot'

  $log_file         = '/var/log/hubot.log'
  $log_level        = 'DEBUG'

  $adapter          = undef
  $irc_nickname     = undef
  $irc_server       = undef
  $irc_rooms        = undef
  $irc_debug        = undef
  $irc_unflood      = undef
}
