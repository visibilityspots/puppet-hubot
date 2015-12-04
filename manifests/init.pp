# Class: hubot
#
# Initialization class for the hubot bot
class hubot (
  $configuration = undef,
)  {

  if $configuration == undef {
    fail('You have to specify the configuration')
  }

  include hubot::install
  include hubot::config
  include hubot::service

  Class['hubot::install'] ->
  Class['hubot::config'] ->
  Class['hubot::service']
}
