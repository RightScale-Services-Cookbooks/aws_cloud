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
  
  if node[:cloud][:provider]!="vagrant"
    right_link_tag "nat:ha=#{node[:aws][:vpc_nat][:nat_ha]}"
    right_link_tag "nat:server_id=#{node[:ec2][:instance_id]}"
  end
  
  log "Test if JAVA_HOME is set properly."
  execute "#{node[:aws][:vpc_nat][:java_home]}/bin/java -version" do
    action :run
  end

  raise "AWS Creds are not setup.  Set aws/vpc_nat/aws_account_id and "+ 
    "aws/vpc_nat/aws_account_secret" unless node[:aws][:vpc_nat][:aws_account_id]
  
  log "NAT HA enabled.  Proceding to install nat-monitor"  
  
  register_monitor "Register NAT HA Montior" do
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
 
  #  aws_nat "attach nat host" do
  #    action :attach
  #  end
  
else
  log "VPC HA is not enabled."
end

rightscale_marker :end
