module BazelCookbook
  class BazelInstallation < ChefCompat::Resource
    property :version, String, default: lazy { default_version }
    default_action :create

    action :nothing do
    end

    private
    def default_version
      node['bazel']['version']
    end
  end
end
