# Class: hubot::install
#
# Installation of the hubot service
class hubot::install {
  package { 'hubot':
    ensure   => 'installed',
  }
}
