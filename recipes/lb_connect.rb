aws_lb "connect to lb" do
  node_id node[:aws][:lb][:instance_id]
  lb_name node[:aws][:lb][:name]
  action :connect
end
