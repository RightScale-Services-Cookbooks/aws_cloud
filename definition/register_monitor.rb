
define :register_slave, :action=> :create do
  # Obtain information about nat ha servers by querying for its tags

  rightscale_server_collection "nat_ha" do
    timeout 3600 #1hr
    tags "nat:ha=enabled"
    mandatory_tags "nat:ha=enabled"
    empty_ok false
    action :load
  end

  
  nat_server_id = ""
  nat_server_ip = ""

  f = ruby_block "find tags from servers" do
    block do
      node[:server_collection]["nat_ha"].each do |id, tags|
        server_ip_tag = tags.detect { |u| u =~ /server:private_ip_0/ }
        nat_server_ip = server_ip_tag.split(/=/, 2).last.chomp
        server_id_tag = tags.detect { |u| u =~ /nat:server_id/ }
        nat_server_id = server_id_tag.split(/=/, 2).last.chomp

        Chef::Log.info "Nat Server ID: #{nat_server_id}"
        Chef::Log.info "Nat Server IP: #{nat_server_ip}"
      end
    end
  end

  f.run_action(:create)
  
  
  template "/root/nat-monitor.sh" do
    source "nat-monitor.erb"
    owner  "root"
    group  "root"
    mode   "0700"
    variables( :other_instance_id=> nat_server_id,
      :my_instance_id=> node[:ec2][:instance_id],
      :other_instance_ip=>  nat_server_ip,
      :ec2_url => node[:aws][:vpc_nat][:ec2_url],
      :java_home => node[:aws][:vpc_nat][:java_home]
    )
    action :create
  end
  
end