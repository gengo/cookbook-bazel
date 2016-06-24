require 'uri'

module BazelCookbook
  class BazelInstallationScript < BazelInstallation
    resource_name :bazel_installation_script
    property :prefix, String, default: lazy { default_prefix }
    property :installer_uri, String, default: lazy { default_installer_uri }
    property :installer_checksum, String, default: lazy { default_installer_hash }

    provides :bazel_installation_script
    provides :bazel_installation, os: ['linux', 'darwin'] do |node|
      node.kernel.machine == 'x86_64'
    end
 
    action :create do
      installer_path = installer_local_path(installer_uri)
      remote_file installer_path do
        source   installer_uri
        checksum installer_checksum
        mode 00755
      end

      execute "#{installer_path} --prefix=#{prefix}" do
        action :nothing
        subscribes :run, "remote_file[#{installer_path}]", :immediately
      end
    end

    def installer_local_path(uri)
      basename = ::File.basename(URI.parse(uri).path)
      return ::File.join(Chef::Config[:file_cache_path], basename)
    end

    private
    def default_prefix
      node.bazel.prefix
    end

    def default_installer_uri
      platform = "#{node.os}-#{node.kernel.machine}"
      installer = "#{version}/bazel-#{version}-installer-#{platform}.sh"
      return "https://github.com/bazelbuild/bazel/releases/download/#{installer}"
    end

    def default_installer_hash
      key = [node.os, version]
      {
        %w[linux  0.2.3] => 'e0e4efe35b2c9f2b1f3c3929fc401e27c312090e6a305c046ecb59b9e3128e00',
        %w[darwin 0.2.3] => 'edd82b987dc40a0f23647cfd5fc7d2af5e47b182ea51c07ca1889f04c4fe2b98',
        %w[linux  0.3.0] => '91cae68d1b200a00c982df204a285042c104a3bfe629af5e8d0f289418f60468',
        %w[darwin 0.3.0] => 'f08216f9bc9c54dd587e0b78881c51083da3152e7184930ba07afb7a51a78e32',
      }[key]
    end
  end
end

=begin
module Kernel
  alias raise_orig raise
  def raise(*args)
    puts caller.join("\n") if ArgumentError === args.first
    raise_orig *args
  end
end
=end
