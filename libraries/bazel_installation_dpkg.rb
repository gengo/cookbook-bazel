require 'uri'

require_relative 'deb_helper'

module BazelCookbook
  class BazelInstallationDpkg < BazelInstallation
    include DebHelper

    resource_name :bazel_installation_dpkg
    property :uri, default: lazy { default_uri }
    provides :bazel_installation_dpkg
    provides :bazel_installation_package, platform_family: 'debian'
    provides :bazel_installation, platform_family: 'debian'

    action :create do
      path = dpkg_local_path(new_resource.uri)
      remote_file path do
        source new_resource.uri
        mode   00644
      end

      dpkg_package 'bazel' do
        source  path
        version new_resource.version
      end
    end

    def dpkg_local_path(uri)
      basename = ::File.basename(URI.parse(uri).path)
      return ::File.join(Chef::Config[:file_cache_path], basename)
    end

    private
    def default_uri
      "https://storage.googleapis.com/bazel-apt/pool/#{repo_component}/b/bazel/bazel_#{version}_amd64.deb"
    end
  end
end



