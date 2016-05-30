name             'bazel'
maintainer       'Gengo Inc.'
maintainer_email 'gge@gengo.com'
source_url       'https://github.com/gengo/cookbook-bazel'
issues_url       'https://github.com/gengo/cookbook-bazel/issues'
license          'BSD 3-Clause License'
description      'Installs/Configures bazel'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'mac_os_x'
supports 'ubuntu'

depends 'build-essential'
depends 'java'
depends 'poise-python'
depends 'zip'
depends 'homebrew'
