#
# Cookbook Name:: vpc-nat
# Cookbook Name:: rightscale_services_tools
#
# Copyright 2013, Rightscale Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

include_recipe "java"

log "Test if JAVA_HOME is set properly."
execute "#{node[:java][:java_home]}/bin/java -version" do
  action :run
end

if node[:aws][:vpc_nat][:nat_ha]=='enabled'
  
  log "NAT HA enabled.  Proceding to install nat-monitor"  
  
  template "/root/nat-monitor.sh" do
    source "nat-monitor.erb"
    owner  "root"
    group  "root"
    mode   "0700"
    variables( :other_instance_id=> node[:aws][:vpc_nat][:other_instance_id],
      :other_route_id=>node[:aws][:vpc_nat][:other_route_id],
      :route_id=>node[:aws][:vpc_nat][:route_id],
      :ec2_url => node[:aws][:vpc_nat][:ec2_url],
      :java_home => node[:aws][:vpc_nat][:java_home]
    )
    action :create
  end
  template "/root/credentials.txt" do
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
