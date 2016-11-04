A puppet-module which configures the [hubot](https://hubot.github.com/) chat bot

I created an rpm package using hubot version 2.13-2 compiled with hubot-xmpp 0.1.5 and hubot-irc 0.2.7.

You could use for my [packagecloud.io](https://packagecloud.io/visibilityspots/packages) repository which you can install on CentOS by:

```bash
$ curl https://packagecloud.io/install/repositories/visibilityspots/packages/script.rpm | sudo bash
```

## Options (init.d)
=======
I created an rpm package using hubot version 2.17-2 compiled with hubot-xmpp 0.1.8. The detailed process how to compile it and create .rpm package is at the end of this README.md

## Example

To implement using the defaults or with hiera support:

```puppet
  node 'hubot' {
    include ::hubot
  }
```

For an implementation with custom values without hiera support (init.d):

```puppet
  node 'hubot' {
    class {
      'hubot':
        $configuration = { 
          HUBOT_LOG_LEVEL => 'ERROR'
          HUBOT_AUTH_ADMIN => 'kayn'
          HUBOT_XMPP_USERNAME => 'hubot@example.com'
          HUBOT_XMPP_PASSWORD => 'password'
          HUBOT_XMPP_ROOMS => 'technical@conference.example.com,dailyops@conference.example.com'
          HUBOT_XMPP_HOST => '127.0.0.1'
        }
    }
  }
```

For an implementation with custom values without hiera support (systemd):

```puppet
  node 'hubot' {
    class {
      'hubot':
        $configuration = { 
          HUBOT_LOG_LEVEL => 'ERROR'
          HUBOT_AUTH_ADMIN => 'kayn'
          HUBOT_XMPP_USERNAME => 'hubot@example.com'
          HUBOT_XMPP_PASSWORD => 'password'
          HUBOT_XMPP_ROOMS => 'technical@conference.example.com,dailyops@conference.example.com'
          HUBOT_XMPP_HOST => '127.0.0.1'
        }
    }
  }
```


## Install + package (systemd) - tested on CentOS 7
=======

```bash
##########################
### NECESSARY PACKAGES ###
##########################

# install the newest 0.10.x version of nodejs and nodejs-devel (it is needed only for compilation!!)
# epel contains version '0.10.36' but we need '0.10.40' for compilation (hubot can run then with 0.10.36)
yum install https://rpm.nodesource.com/pub_0.10/el/7/x86_64/nodejs-0.10.40-1nodesource.el7.centos.x86_64.rpm
yum install https://rpm.nodesource.com/pub_0.10/el/7/x86_64/nodejs-devel-0.10.40-1nodesource.el7.centos.x86_64.rpm

# install the rest of needed packages
yum install npm libicu-devel expat-devel git 

###########
### NPM ###
###########

mkdir hubot;cd hubot;

npm install yo generator-hubot

mkdir hubot;cd hubot
../node_modules/.bin/yo hubot

# now, fill in following configuration (important is xmpp adapter!!!):

=======
? Owner hubot@inuits.eu
? Bot name hubot
? Description A simple helpful robot for your Company
? Bot adapter (campfire) xmppgot back false
? Bot adapter xmpp

# now let's install necessary packages

sed -i '/hubot-heroku-keepalive/d' external-scripts.json
# npm is not installed because it's needed on the machine where hubot will be installed
sed -i 's/npm install/# npm install/' bin/hubot
npm uninstall hubot-heroku-keepalive --save
npm install jsdom@4.0.0 --save
npm instal gitio --save

npm install

################################################
### SYSTEMD SERVICE FILE + BEFORE_INSTALL.SH ###
################################################

# now you hubot install in current directory....let's package it to .rpm

# go back
cd ..

# you should see following direcories if you run `ls`
hubot  node_modules

# now you need to create 3 necessary files with following content:

cat << EOF > before-install.sh
#!/bin/sh
if ! id -u "hubot" >/dev/null 2>&1; then
  useradd hubot
  fi
  EOF

  cat << EOF > hubot.conf
  # It is supposed that you will place here environment variables.

  # You can find couple of examples below:

  [Service]
  # # Common parameters
  # Environment=HUBOT_LOG_LEVEL=ERROR
  # Environment=HUBOT_AUTH_ADMIN=admin
  #  
  # # XMPP adapter parameters
  # Environment=HUBOT_XMPP_USERNAME=hubot@example.com
  # Environment=HUBOT_XMPP_PASSWORD=ultra_safe_password
  # Environment=HUBOT_XMPP_ROOMS=technical@conference.example.com,dailyops@conference.example.com
  # Environment=HUBOT_XMPP_HOST=localhost
  # Environment=HUBOT_XMPP_PORT=5222
  # Environment=HUBOT_XMPP_LEGACYSSL=0    # do not use until it's necessary, I had some issue with that parameter
  # 
  # Environment=HUBOT_GRAFANA_HOST=https://grafana.example.com/
  # Environment=HUBOT_GRAFANA_API_KEY=place_api_key_here

  # # Redime parameters
  # Environment=HUBOT_REDMINE_BASE_URL=http://redmine.example.com
  # Environment=HUBOT_REDMINE_TOKEN=place_redmine_token_here
  # Environment=HUBOT_REDMINE_SSL=1
  # Environment=HUBOT_MEMEGEN_USERNAME=UNDEFINED
  # Environment=HUBOT_MEMEGEN_PASSWORD=UNDEFINED
  # Environment=HUBOT_MEMEGEN_DIMENSIONS=UNDEFINED
  EOF

  cat << EOF > hubot.service
  ; Hubot systemd service unit file
  ; Place in e.g. `/etc/systemd/system/hubot.service`, then `systemctl daemon-reload` and `service hubot start`.

  [Unit]
  Description=Hubot
  Requires=network.target
  After=network.target

  [Service]
  Type=simple
  WorkingDirectory=/opt/hubot
  User=hubot

  Restart=always
  RestartSec=10

  ; Configure Hubot environment variables, make sure to use quotes around whitespace as shown below.
  ; Environment=HUBOT_aaa=xxx "HUBOT_bbb='yyy yyy'" 

  ; NOTE: environment variables are defined by puppet in /etc/systemd/system/hubot.service.d/hubot.conf

  ExecStart=/opt/hubot/bin/hubot --adapter xmpp

  [Install]
  WantedBy=multi-user.target
  EOF

#################
### FPM MAGIC ###
#################

  # needed files created, now we can build rpm with following fpm command:

  fpm -s dir -t rpm -d nodejs -v 2.17 --iteration 2 --epoch 2 --description "Hubot chatbot with preloaded xmpp 0.1.8 adapter" -n hubot --before-install before-install.sh hubot=/opt hubot.service=/etc/systemd/system/hubot.service hubot.conf=/etc/systemd/system/hubot.service.d/hubot.conf
```
