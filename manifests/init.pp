# Class: hubot
#
# Initialization class for the hubot bot
class hubot (
  # mandatory parameter for OS with systemd
  $configuration = undef,

  # following parameters are not needed for OS with systemd
  $log_level                     = $hubot::params::log_level,
  $adapter                       = $hubot::params::adapter,
)  {

  if $configuration == undef {
    fail('You have to specify the configuration')
  }

  if ($::service_provider == 'systemd') and ($configuration == undef) {
    fail('You have to specify the $configuration parameter.')
  }

  include hubot::install
  include hubot::config
  include hubot::service

  Class['hubot::install'] ->
  Class['hubot::config'] ->
  Class['hubot::service']
}
