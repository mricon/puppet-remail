# == Class: remail::install
#
# Manages the installation of Remail
#
# === Authors
#
# Konstantin Ryabitsev <konstantin@linuxfoundation.org>
#
# === Copyright
#
# Copyright (C) 2019 by The Linux Foundation
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
class remail::install {
  include ::git

  if $remail::manage_user {
    user { $remail::user:
      ensure     => present,
      home       => $remail::home_dir,
      shell      => '/bin/bash',
      managehome => false,
      password   => '!!',
      comment    => 'User for managing Remail',
      gid        => $remail::group,
    }
  }

  if $remail::manage_group {
    group { $remail::group:
      ensure => present,
    }
  }

  file { $remail::home_dir:
    ensure => 'directory',
    owner  => $remail::user,
    group  => $remail::group,
    mode   => '0711',
  }

  file { $remail::install_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  case $remail::version {
    'latest': {
      $vcsrepo_ensure = 'latest'
      $revision       = 'master'
    }
    default: {
      $vcsrepo_ensure = 'present'
      $revision       = $remail::version
    }
  }

  vcsrepo { $remail::install_dir:
    ensure   => $vcsrepo_ensure,
    provider => 'git',
    user     => 'root',
    group    => 'root',
    source   => $remail::source_repo,
    revision => $revision,
    require  => File[$remail::install_dir],
  }

  package {['gcc-c++', "${remail::python_package}-devel", 'openssl-devel']:
    ensure => installed,
  }

  # Create a virtualenv and install required libraries
  $venv_dir = "${remail::install_dir}/.venv"
  python::pyvenv { $venv_dir:
    version => $remail::python_version,
    owner   => 'root',
    group   => 'root',
    require => [
      Class['::python'],
      Vcsrepo[$remail::install_dir],
    ],
  }

  python::requirements { "${remail::install_dir}/requirements.txt":
    virtualenv => $venv_dir,
    owner      => 'root',
    group      => 'root',
    require    => [
      Class['::python'],
      Python::Pyvenv[$venv_dir],
      Package['gcc-c++'],
      Package["${remail::python_package}-devel"],
      Package['openssl-devel'],
      Vcsrepo[$remail::install_dir],
    ],
  }
}
