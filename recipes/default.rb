#
# Cookbook Name:: bazel
# Recipe:: default
#
# Copyright 2016, Gengo Inc.
#
# All rights reserved - BSD 3-Clause License
#

include_recipe 'java'
include_recipe 'zip' unless node.platform_family == 'mac_os_x'

case spec = [node.os, node.kernel.machine]
when ['darwin', 'x86_64'], ['linux', 'x86_64']
  version = node.bazel.version
  installer = "#{version}/bazel-#{version}-installer-#{spec[0]}-#{spec[1]}.sh"
  installer_path = File.join(Chef::Config[:file_cache_path], File.basename(installer))

  remote_file installer_path do
    source "https://github.com/bazelbuild/bazel/releases/download/#{installer}"
    mode 00755
  end

  prefix = node.bazel.prefix
  execute "#{installer_path} --prefix=#{prefix}" do
    action :nothing
    subscribes :run, "remote_file[#{installer_path}]", :immediately
  end
else
  raise 'only supports darwin and linux'
end
