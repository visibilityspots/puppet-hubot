# puppet-hubot module [![Build Status](https://travis-ci.org/visibilityspots/puppet-hubot.svg?branch=master)](https://travis-ci.org/visibilityspots/puppet-hubot)

A puppet-module which configures the [hubot](https://hubot.github.com/) chat bot

I created an rpm package using hubot version 2.13-2 compiled with hubot-xmpp 0.1.5 and hubot-irc 0.2.7.

You could use for my [packagecloud.io](https://packagecloud.io/visibilityspots/packages) repository which you can install on CentOS by:

```bash
$ curl https://packagecloud.io/install/repositories/visibilityspots/packages/script.rpm | sudo bash
```

## Options

```puppet
  $log_level                     = 'ERROR'
  $adapter                       = 'irc'

  $irc_nickname                  = 'myhubot'
  $irc_server                    = 'irc.freenode.net'
  $irc_rooms                     = '#myhubot-irc'
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
```

## Example

To implement using the defaults or with hiera support:

```puppet
  node 'hubot' {
    include ::hubot
  }
```

For an implementation with custom values without hiera support:

```puppet
  node 'hubot' {
    class {
      'hubot':
        irc_nickname => 'myhubot',
        irc_server   => 'irc.freenode.net',
        irc_rooms    => '#myhubot-irc',
    }
  }
```
