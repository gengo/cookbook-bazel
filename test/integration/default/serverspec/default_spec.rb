require_relative 'spec_helper'

describe command('bazel') do
  its(:exit_status) { should eq 0 }
end
