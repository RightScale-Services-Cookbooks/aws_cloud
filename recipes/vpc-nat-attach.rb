  
#run remote recipe on primary nat server
rightscale_marker :begin

unless node[:aws][:vpc_nat][:primary]=='true'
  # get the server info of the primary nat host.
  rightscale_server_collection "nat_ha" do
    #timeout 1800 #30min
    tags "nat:ha=active"
    mandatory_tags  ["nat:server_id=*", "server:private_ip_0=*"]
    #empty_ok false
    action :load
  end
  
  nat_server_id = ""
  nat_server_ip = ""
  
  ruby_block "find tags from servers" do
    block do
      node[:server_collection]["nat_ha"].each do |id, tags|
        server_ip_tag = tags.detect { |u| u =~ /server:private_ip_0/ }
        nat_server_ip = server_ip_tag.split(/=/, 2).last.chomp
        server_id_tag = tags.detect { |u| u =~ /nat:server_id/ }
        nat_server_id = server_id_tag.split(/=/, 2).last.chomp
  
        Chef::Log.info "Nat Server ID: #{nat_server_id}"
        Chef::Log.info "Nat Server IP: #{nat_server_ip}"
#        node[:vpc_nat][:server_id] = nat_server_id
#        node[:vpc_nat][:server_ip] = nat_server_ip
      end
    end
  end
  
  #include_recipe 'aws::vpc-nat-ha' 
 
  aws_nat "Setup Nat Monitor" do
    server_id nat_server_id
    server_ip nat_server_ip
    action :setup_nat_monitor
  end
  
  # trigger recipe on primary host
  remote_recipe "Setup Monitor on primary host" do
    recipe "aws::vpc-nat-remote-attach"
    attributes :remote_recipe => {
      :server_id => node[:ec2][:instance_id],
      :server_ip => node[:cloud][:private_ips][0]
    }
    recipients_tags "nat:ha=active"
  end  
end

rightscale_marker :end
  
