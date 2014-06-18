#
# Cookbook Name:: vpc-nat
# Cookbook Name:: rightscale_services_tools
#
# Copyright 2013, Rightscale Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

if node[:aws][:vpc_nat][:nat_ha]=='enabled'

  #include_recipe "java"

  log "Test if JAVA_HOME is set properly."
  execute "#{node[:java][:java_home]}/bin/java -version" do
    action :run
  end

  raise "AWS Creds are not setup.  Set aws/vpc_nat/aws_account_id and "+ 
    "aws/vpc_nat/aws_account_secret" unless node[:aws][:vpc_nat][:aws_account_id]
  
  log "NAT HA enabled.  Proceding to install nat-monitor"  
  
  # Obtain information about nat ha servers by querying for its tags
  r = rightscale_server_collection "nat_ha" do
    tags "nat:ha=enabled"
    mandatory_tags "nat:ha=enabled"
    action :nothing
  end
  r.run_action(:load)

  nat_server_id = ""
  nat_server_ip = ""

  r = ruby_block "find ha servers" do
    block do
      node[:server_collection]["nat_ha"].each do |id, tags|
        server_ip_tag = tags.detect { |u| u =~ /nat:server_ip/ }
        nat_server_ip = server_ip_tag.split(/=/, 2).last.chomp
        server_id_tag = tags.detect { |u| u =~ /nat:server_id/ }
        nat_server_id = server_id_tag.split(/=/, 2).last.chomp

        Chef::Log.info "Nat Server ID: #{nat_server_id}"
        Chef::Log.info "Nat Server IP: #{nat_server_ip}"
      end
    end
  end

  r.run_action(:create)
  
  
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
  template "/root/.awscreds" do
    source "credentials.erb"
    owner  "root"
    group  "root"
    mode   "0400"
    variables( :key=> node[:aws][:vpc_nat][:aws_account_id],
      :secret=>node[:aws][:vpc_nat][:aws_account_secret]
    )
    action :create
  end

  # not sure if this will every take affect
  bash "install cron to run on reboot" do
    user "root"
    cwd "/root"
    code <<-EOH
  echo '@reboot /root/nat-monitor.sh > /var/log/nat-monitor.log 2>&1' | crontab
    EOH
  end

  aws_nat "start monitor" do
    action :start_nat_monitor
  end
 
else
  log "VPC HA is not enabled."
end

rightscale_marker :end
