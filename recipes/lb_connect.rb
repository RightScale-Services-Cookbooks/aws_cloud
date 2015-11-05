include_recipe 'fog::default'

aws_lb 'connect to lb' do
  node_id node[:aws][:lb][:node_id]
  lb_name node[:aws][:lb][:name]
  action :connect
end
