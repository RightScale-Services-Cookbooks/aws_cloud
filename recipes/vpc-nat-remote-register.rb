  
#run remote recipe on primary nat server
rightscale_marker :begin

aws_nat "attach nat host" do
  server_id node[:ec2][:instance_id]
  server_ip node[:cloud][:private_ips][0]
  action :attach
end

rightscale_marker :end
  
