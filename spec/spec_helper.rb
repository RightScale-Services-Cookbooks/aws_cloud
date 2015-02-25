libraries_path = File.expand_path('../../libraries', __FILE__)
$LOAD_PATH.unshift(libraries_path) unless $LOAD_PATH.include?(libraries_path)

require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '6.6'
  config.log_level = :error
end
