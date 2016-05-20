include_recipe 'build-essential'

package 'g++' if platform_family?('debian')
