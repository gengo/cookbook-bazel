require_relative '../spec_helper'

describe 'bazel::bazel' do
  [
    %w[ ubuntu   14.04   ],
    %w[ mac_os_x 10.11.1 ],
  ].each do |platform, version|
    context "on #{platform} #{version}" do
      let(:chef_run) {
        runner = ChefSpec::SoloRunner.new(
          platform: platform, version: version) do |node|
            node.set.bazel.version = '0.2.0'
            node.set.bazel.prefix = '/opt/local/libexec'
          end
        runner.converge(described_recipe)
      }
      let(:installer_name) do
        case platform
        when 'mac_os_x'
          'bazel-0.2.0-installer-darwin-x86_64.sh'
        else
          'bazel-0.2.0-installer-linux-x86_64.sh'
        end
      end
      let(:installer_path) {
        File.join(Chef::Config[:file_cache_path], installer_name)
      }

      it 'installs JDK' do
        expect(chef_run).to include_recipe('java')
      end

      if platform == 'mac_os_x'
        it 'uses unzip already available' do
          expect(chef_run).not_to include_recipe('zip')
        end
      else
        it 'installs unzip' do
          expect(chef_run).to include_recipe('zip')
        end
      end

      it 'downloads bazel installer' do
        expect(chef_run).to create_remote_file(installer_path).with(mode: 00755)
      end
      it 'installs bazel on update' do
        installer = chef_run.execute("#{installer_path} --prefix=/opt/local/libexec")
        expect(installer).to do_nothing
        expect(installer).to subscribe_to("remote_file[#{installer_path}]")
      end
    end
  end
end
