module BazelCookbook
  class BazelInstallationHomebrew < BazelInstallation
    resource_name :bazel_installation_homebrew
    provides :bazel_installation_homebrew
    provides :bazel_installation_package, platform_family: 'mac_os_x'
    provides :bazel_installation, platform_family: 'mac_os_x'

    action :create do
      homebrew_package 'bazel' do
        version new_resource.version
      end
    end
  end
end

