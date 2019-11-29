# == Class: remail::config
#
# Manages the main remail configuration file
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
class remail::config (
  # Remail configuration file is YAML, so just accept
  # a dictionary and let it be done via hiera
  Hash $maincfg = {},
) inherits remail {

  file { "${remail::home_dir}/remail.yaml":
    ensure  => file,
    mode    => '0644',
    owner   => $remail::user,
    group   => $remail::group,
    content => inline_template('<%= @maincfg.to_yaml %>'),
  }
}
