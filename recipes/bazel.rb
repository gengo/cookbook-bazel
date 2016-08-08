#
# Cookbook Name:: bazel
# Recipe:: bazel
#
# Copyright 2016, Gengo Inc.
#
# All rights reserved - BSD 3-Clause License
#

include_recipe 'java'
include_recipe 'bazel::cxx'

case node['bazel']['installation_method']
when 'apt'
  bazel_installation_apt 'bazel' do
    action :create
  end
when 'dpkg'
  bazel_installation_dpkg 'bazel' do
    action :create
  end
when 'homebrew'
  bazel_installation_homebrew 'bazel' do
    action :create
  end
when 'package'
  bazel_installation_package 'bazel' do
    action :create
  end
when 'script'
  include_recipe 'zip' unless node['platform_family'] == 'mac_os_x'
  bazel_installation_script 'bazel' do
    action :create
    node['bazel']['installation_script'].each do |name, value|
      send(name, value)
    end
  end
else
  include_recipe 'zip' unless node['platform_family'] == 'mac_os_x'
  bazel_installation 'bazel' do
    action :create
  end
end
