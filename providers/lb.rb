
action :connect do
  require 'fog'
  elb_name=@new_resource.lb_name
  node_id=@new_resource.node_id
  elb=Fog::AWS::ELB.new(
      :aws_access_key_id => node[:aws][:aws_access_key_id],
      :aws_secret_access_key => node[:aws][:aws_secret_access_key],
      :region  => node[:aws][:region] )
  elb.register_instances_with_load_balancer([node_id],elb_name)
  new_resource.updated_by_last_action(true)
end

action :disconnect do
  require 'fog'
  elb_name=@new_resource.lb_name
  node_id=@new_resource.node_id
  elb=Fog::AWS::ELB.new(
      :aws_access_key_id => node[:aws][:aws_access_key_id],
      :aws_secret_access_key => node[:aws][:aws_secret_access_key],
      :region => node[:aws][:region] )
  elb.deregister_instances_from_load_balancer([node_id],node_id)
  new_resource.updated_by_last_action(true)
end
