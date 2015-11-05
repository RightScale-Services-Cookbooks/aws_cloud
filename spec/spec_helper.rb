libraries_path = File.expand_path('../../libraries', __FILE__)
$LOAD_PATH.unshift(libraries_path) unless $LOAD_PATH.include?(libraries_path)

require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start!

RSpec.configure do |config|
  config.log_level = :error
  config.platform = 'ubuntu'
  # Specify the operating version to mock Ohai data from (default: nil)
  config.version = '12.04'
end