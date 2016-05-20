require_relative 'spec_helper'

# tools required by CROSSTOOL
[
  'gcc --version',
  'g++ --version',
  'gcov --version',
  'nm --version',
].each do |commandline|
  describe command(commandline) do
    its(:exit_status) { should eq 0 }
  end
end
