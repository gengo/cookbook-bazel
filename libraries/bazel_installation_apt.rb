require_relative 'deb_helper'

module BazelCookbook
  class BazelInstallationApt < BazelInstallation
    include DebHelper

    resource_name :bazel_installation_apt
    provides :bazel_installation_apt
    provides :bazel_installation_package, platform_family: 'debian'
    provides :bazel_installation, platform_family: 'debian'

    action :create do
      apt_repository 'bazel' do
        uri          'http://storage.googleapis.com/bazel-apt'
        distribution 'stable'
        components   [repo_component]
        key          'https://storage.googleapis.com/bazel-apt/doc/apt-key.pub.gpg'
      end

      apt_package 'bazel' do
        version new_resource.version
      end
    end
  end
end


