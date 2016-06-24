require_relative 'spec_helper'

describe command('bazel') do
  its(:exit_status) { should eq 0 }
end

workspace = File.join(File.dirname(__FILE__), 'test_workspace')
is_redhat = File.exist?('/etc/redhat-release')
describe command("cd #{workspace} && bazel run //:cc_hello") do
  its(:exit_status) {
    pending 'needs a custom CROSSTOOL' if is_redhat
    should eq 0
  }
  its(:stdout) {
    pending 'needs a custom CROSSTOOL' if is_redhat
    should contain /Hello, World!/
  }
end

describe command("cd #{workspace} && bazel run //:java_hello") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain /Hello, World!/ }
end

describe command("cd #{workspace} && bazel run //:py2_hello") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain /Hello, World!/ }
  its(:stdout) { should contain /^version: 2\.7/ }
end

opt = is_redhat ? {pending: 'python3 is not enabled'} : {}
describe command("cd #{workspace} && bazel run //:py3_hello"), **opt do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain /Hello, World!/ }
  its(:stdout) { should contain /^version: 3/ }
end
