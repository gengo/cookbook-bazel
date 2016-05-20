require_relative '../spec_helper'

describe 'bazel::cxx' do
  [
    %w[ ubuntu   14.04    ],
    %w[ centos   7.2.1511 ],
    %w[ mac_os_x 10.11.1  ],
  ].each do |platform, version|
    context "on #{platform} #{version}" do
      let(:chef_run) {
        runner = ChefSpec::SoloRunner.new(platform: platform, version: version)
        runner.converge(described_recipe)
      }

      it 'installs build essential' do
        expect(chef_run).to include_recipe('build-essential')
      end

      case platform
      when 'ubuntu'
        it 'installs C++ compiler' do
          expect(chef_run).to install_package('g++')
        end
      end
    end
  end
end
