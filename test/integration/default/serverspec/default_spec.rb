require_relative 'spec_helper'

describe command('/usr/local/bin/bazel') do
  its(:exit_status) { should eq 0 }
end

workspace = File.join(File.dirname(__FILE__), 'test_workspace')
describe command("cd #{workspace} && /usr/local/bin/bazel run //:cc_hello") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain /Hello, World!/ }
end

describe command("cd #{workspace} && /usr/local/bin/bazel run //:java_hello") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain /Hello, World!/ }
end

describe command("cd #{workspace} && /usr/local/bin/bazel run //:py2_hello") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain /Hello, World!/ }
  its(:stdout) { should contain /^version: 2\.7/ }
end

describe command("cd #{workspace} && /usr/local/bin/bazel run //:py3_hello") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should contain /Hello, World!/ }
  its(:stdout) { should contain /^version: 3/ }
end
