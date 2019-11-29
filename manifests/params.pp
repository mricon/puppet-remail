# == Class: remail::params
#
# Parameter definition for remail. See init.pp for documentation.
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
class remail::params {
  $install_dir      = '/usr/local/remail'
  $home_dir         = '/home/remail'
  $version          = 'latest'
  $manage_user      = true
  $user             = 'remail'
  $manage_group     = true
  $group            = 'remail'
  $source_repo      = 'https://git.kernel.org/pub/scm/linux/kernel/git/tglx/remail.git'
  $python_package   = 'python3'
  $python_version   = '3'
}
