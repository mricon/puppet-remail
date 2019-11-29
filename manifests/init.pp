# == Class: remail
#
# A simplistic but powerfull crypted mailing list tool set.
#
#  https://git.kernel.org/pub/scm/linux/kernel/git/tglx/remail.git
#
# === Authors
#
# Konstantin Ryabitsev <konstantin@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2019 by The Linux Foundation
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
class remail (
  Pattern['^\/']        $install_dir     = $remail::params::install_dir,
  Pattern['^\/']        $home_dir        = $remail::params::home_dir,
  String                $version         = $remail::params::version,
  Boolean               $manage_user     = $remail::params::manage_user,
  String                $user            = $remail::params::user,
  Boolean               $manage_group    = $remail::params::manage_group,
  String                $group           = $remail::params::group,
  String                $source_repo     = $remail::params::source_repo,

  String                $python_package  = $remail::params::python_package,
  String                $python_version  = $remail::params::python_version,

) inherits remail::params {

  anchor { 'remail:begin': }
  anchor { 'remail:end': }

  include '::remail::install'
  include '::remail::config'

  Anchor['remail:begin']
    ->Class['::remail::install']
    ->Class['::remail::config']
    ->Anchor['remail:end']
}
