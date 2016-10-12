include_attribute 'java'
default['java']['jdk_version'] = 8

default['bazel']['version'] = '0.3.2'
default['bazel']['prefix'] = '/usr/local'
default['bazel']['installation_method'] = nil  # automatic

default['bazel']['installation_script'] = {}
default['bazel']['installation_dpkg']['uri'] = nil
