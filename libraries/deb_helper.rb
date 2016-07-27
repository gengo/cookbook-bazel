module BazelCookbook
  module DebHelper
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
