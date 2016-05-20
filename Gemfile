source 'https://rubygems.org'

gem 'rake'

gem 'chef-dk'
gem 'berkshelf', '~> 4.3'
gem 'test-kitchen', '~> 1.7'

group :vagrant do
  gem 'kitchen-vagrant'
end

group :docker do
  gem 'kitchen-docker_cli', '~> 0.15.0'
end

group :local do
  gem 'kitchen-local', git: 'https://github.com/gengo/kitchen-local.git'
end
