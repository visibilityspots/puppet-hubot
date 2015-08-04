# Class hubot::params
#
# This class contains every parameter which will be used in this puppet module
# for setting up the hubot bot
class hubot::params {
  $log_level                     = 'ERROR'
  $adapter                       = 'xmpp'

  $irc_nickname                  = undef
  $irc_server                    = undef
  $irc_rooms                     = undef
  $irc_debug                     = false
  $irc_unflood                   = false
  $irc_port                      = undef
  $irc_password                  = undef
  $irc_nickserv_password         = undef
  $irc_nickserv_username         = undef
  $irc_server_fake_ssl           = false
  $irc_usessl                    = false

  $xmpp_username                 = undef
  $xmpp_password                 = undef
  $xmpp_rooms                    = undef
  $xmpp_host                     = undef
  $xmpp_port                     = undef
  $xmpp_legacyssl                = false
  $xmpp_preferred_sasl_mechanism = undef
}
