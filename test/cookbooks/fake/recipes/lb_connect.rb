include_recipe "fog::default"

#chef_gem 'fog'
require 'fog'
require "fog/aws"
#r= ruby_block 'fog mock' do
#  block do
    Fog.mock!
#  end
#  action :nothing
#end

 #r.run_action(:run)

include_recipe "aws::lb_connect"
