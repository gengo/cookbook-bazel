module BazelCookbook
  class BazelInstallationApt < BazelInstallation
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

    def repo_component
      ver = node.java.jdk_version
      case ver
      when 8
        'jdk1.8'
      when 7
        'jdk1.7'
      else
        raise "Bazel supports only JDK 7 and 8 but got node.java.jdk = #{ver}"
      end
    end
  end
end


