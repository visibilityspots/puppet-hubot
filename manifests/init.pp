# Class: hubot
#
# Initialization class for the hubot bot
class hubot (
  # mandatory parameter for OS with systemd
  $configuration = undef,

  # following parameters are not needed for OS with systemd
  $log_level                     = $hubot::params::log_level,
  $adapter                       = $hubot::params::adapter,

  $irc_nickname                  = $hubot::params::irc_nickname,
  $irc_server                    = $hubot::params::irc_server,
  $irc_rooms                     = $hubot::params::irc_rooms,
  $irc_debug                     = $hubot::params::irc_debug,
  $irc_unflood                   = $hubot::params::irc_unflood,
  $irc_port                      = $hubot::params::irc_port,
  $irc_password                  = $hubot::params::irc_password,
  $irc_nickserv_password         = $hubot::params::irc_nickserv_password,
  $irc_nickserv_username         = $hubot::params::irc_nickserv_username,
  $irc_server_fake_ssl           = $hubot::params::irc_server_fake_ssl,
  $irc_usessl                    = $hubot::params::irc_usessl,

  $xmpp_username                 = $hubot::params::xmpp_username,
  $xmpp_password                 = $hubot::params::xmpp_password,
  $xmpp_rooms                    = $hubot::params::xmpp_rooms,
  $xmpp_host                     = $hubot::params::xmpp_host,
  $xmpp_port                     = $hubot::params::xmpp_port,
  $xmpp_legacyssl                = $hubot::params::xmpp_legacyssl,
  $xmpp_preferred_sasl_mechanism = $hubot::params::xmpp_preferred_sasl_mechanism,

) inherits hubot::params {

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
