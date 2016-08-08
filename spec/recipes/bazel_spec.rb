require_relative '../spec_helper'

describe 'bazel::bazel' do
  [
    %w[ ubuntu   14.04   ],
    %w[ mac_os_x 10.11.1 ],
  ].each do |platform, version|
    context "on #{platform} #{version}" do
      let(:chef_run) {
        runner = ChefSpec::SoloRunner.new(
          platform: platform, version: version,
          step_into: 'bazel_installation',
        ) do |node|
            node.override['bazel']['version'] = '0.2.3'
            node.override['bazel']['prefix'] = '/opt/local/libexec'
          end
        runner.converge(described_recipe)
      }
      let(:installer_name) do
        case platform
        when 'mac_os_x'
          'bazel-0.2.3-installer-darwin-x86_64.sh'
        else
          'bazel-0.2.3-installer-linux-x86_64.sh'
        end
      end
      let(:installer_path) {
        File.join(Chef::Config[:file_cache_path], installer_name)
      }
      before do
        stub_command("which git").and_return(true)
      end

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

  describe 'with homebrew provider' do
    let(:chef_run) {
      runner = ChefSpec::SoloRunner.new(
        platform: 'mac_os_x', version: '10.11.1',
        step_into: 'bazel_installation_homebrew',
      ) do |node|
        node.override['bazel']['version'] = '0.2.3'
        node.override['bazel']['installation_method'] = 'homebrew'
      end
      runner.converge(described_recipe)
    }

    before {
      stub_command("which git").and_return(true)
    }

    it 'installs bazel package' do
      expect(chef_run).to install_homebrew_package('bazel').
        with(version: '0.2.3')
    end
  end

  describe 'with apt provider' do
    let(:chef_run) {
      runner = ChefSpec::SoloRunner.new(
        platform: 'ubuntu', version: '14.04',
        step_into: 'bazel_installation_apt',
      ) do |node|
        node.override['bazel']['version'] = '0.2.3'
        node.override['bazel']['installation_method'] = 'apt'
      end
      runner.converge(described_recipe)
    }

    it 'reigsters bazel apt source' do
      expect(chef_run).to add_apt_repository('bazel')
    end

    it 'installs bazel package' do
      expect(chef_run).to install_apt_package('bazel').
        with(version: '0.2.3')
    end
  end

  describe 'with dpkg provider' do
    let(:chef_run) {
      runner = ChefSpec::SoloRunner.new(
        platform: 'ubuntu', version: '14.04',
        step_into: 'bazel_installation_dpkg',
      ) do |node|
        node.override['bazel']['version'] = '0.3.1~rc1'
        node.override['bazel']['installation_method'] = 'dpkg'
      end
      runner.converge(described_recipe)
    }

    let(:deb_path) {
      File.join(Chef::Config[:file_cache_path], "bazel_0.3.1~rc1_amd64.deb")
    }

    it 'downloads deb file' do
      expect(chef_run).to create_remote_file(deb_path)
    end

    it 'installs bazel package' do
      expect(chef_run).to install_dpkg_package('bazel').
        with(source: deb_path)
    end
  end
end
