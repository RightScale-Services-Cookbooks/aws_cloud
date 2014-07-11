  
#run remote recipe on primary nat server
rightscale_marker :begin

# use remote recipe attributes for the recipe
#node[:vpc_nat][:server_id]=node[:remote_recipe][:server_id]
#node[:vpc_nat][:server_ip]=node[:remote_recipe][:server_ip]
#include_recipe 'aws::vpc-nat-ha' 
   
aws_nat "Setup NAT Monitor" do
  server_id node[:remote_recipe][:server_id]
  server_ip node[:remote_recipe][:server_ip]
  action :setup_nat_monitor
end

rightscale_marker :end
  
