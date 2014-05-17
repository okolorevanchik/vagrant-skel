#
# This manifest describes development environment
# RabbitMQ-server
#

class { 'timezone':
    timezone => 'Europe/Moscow',
}

class { 'locales':
    locales  => ['ru_RU.UTF-8 UTF-8'],
}

#  apt-get update
# ---------------------------------------
class apt_install {
    exec {'update':
        command => 'apt-get update',
        path    => '/usr/bin',
        timeout => 0,
    } ->
    package {[
              'vim',
            ]:
            ensure  => installed,
    }
 }

# RabbitMQ service
class rabbitmq_install {
    class { '::rabbitmq':
        service_manage    => false,
        port              => '5672',
        delete_guest_user => true,
    }
    rabbitmq_user { 'developer':
        admin    => true,
        password => 'Password',
   }
   rabbitmq_vhost { 'habr':
       ensure => present,
   }
   rabbitmq_user_permissions { 'developer@habr':
       configure_permission => '.*',
       read_permission      => '.*',
       write_permission     => '.*',
   }
  rabbitmq_plugin {'rabbitmq_management':
       ensure => present,
  }
}

class java_install {
    class { "java":
      version        => "1.7",
      jdk            => true,
      jre            => true,
      sources        => false,
      javadoc        => false,
      set_as_default => true,
      export_path    => false,
      vendor         => "oracle",
    }
}

class file_test {
    file{'/tmp/example-file.txt':
        ensure => file,
        source => 'puppet:///files/example-file.txt',
    }
}

# Include classes
include apt_install
include timezone
include locales
include rabbitmq_install
include java_install
include file_test
