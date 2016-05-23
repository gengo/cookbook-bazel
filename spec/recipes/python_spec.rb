require_relative '../spec_helper'

describe 'bazel::python' do
  [
    %w[ ubuntu   14.04    ],
    %w[ centos   7.2.1511 ],
  ].each do |platform, version|
    context "on #{platform} #{version}" do
      let(:chef_run) {
        runner = ChefSpec::SoloRunner.new(platform: platform, version: version)
        runner.converge(described_recipe)
      }

      it 'installs python2 runtime' do
        expect(chef_run).to install_python_runtime('2')
      end
      it 'installs python3 runtime' do
        expect(chef_run).to install_python_runtime('3')
      end
      it 'installs python package' do
        expect(chef_run).to install_package('python')
      end
    end
  end

  context 'on mac_os_x' do
    let(:chef_run) {
      runner = ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.11.1')
      runner.converge(described_recipe)
    }

    it 'uses preinstalled python2' do
      expect(chef_run).not_to install_python_runtime(anything)
    end
    it 'installs python3 with homebrew' do
      expect(chef_run).to install_package('python3')
    end
  end
end
