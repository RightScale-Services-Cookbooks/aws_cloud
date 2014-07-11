  
#run remote recipe on primary nat server
rightscale_marker :begin

#aws_nat "attach nat host" do
#  #server_id node[:ec2][:instance_id]
#  #server_ip node[:cloud][:private_ips][0]
#  action :attach
#  not_if node[:aws][:vpc_nat][:primary]=='true'
#end

include_recipe 'aws::vpc-nat-ha' unless node[:aws][:vpc_nat][:primary]=='true'
   
aws_nat "remote attach nat host" do
  #server_id node[:ec2][:instance_id]
  #server_ip node[:cloud][:private_ips][0]
  action :remote_attach
  not_if node[:aws][:vpc_nat][:primary]=='true'
end

rightscale_marker :end
  
