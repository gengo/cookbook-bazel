require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.color = $stdout.tty?
  config.default_formatter = 'doc'
  config.file_cache_path = '/var/chef/cache'
end
ChefSpec::Coverage.start!
