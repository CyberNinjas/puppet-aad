node default {
  case $::operatingsystem {
    'Ubuntu': {
      case $::lsbdistcodename {
        'bionic': {
          class { 'apt':
            update => {
              frequency => 'daily',
              loglevel  => 'debug'
            }
          }
          apt::key { 'Launchpad PPA for Lucas Ramage':
            id     => 'C7277B00CF5A8F6CF14D9A36A2C0BCEBD63BA8C1',
            server => 'keyserver.ubuntu.com'
          }
          apt::key { 'Launchpad PPA for lramage@cyberninjas.com':
            id     => '8C7C0551ED21508C4A8CC83368D35504E523B6B5',
            server => 'keyserver.ubuntu.com'
          }
          apt::ppa { 'ppa:lramage/sds': }
          apt::ppa { 'ppa:jnchi/ppa': }

          package { 'libnss-aad':
            ensure => installed
          }

          package { 'libpam-aad':
            ensure => installed
          }

          package { 'openvpn-auth-aad':
            ensure => installed
          }
        }
        default: {
          fail("Unsupported Ubuntu Release: ${::lsbdistcodename}")
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
