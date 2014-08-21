#
# Cookbook Name:: aws
# Recipe:: start-nat-monitor
#
# Copyright 2013, Rightscale Inc.
#
# All rights reserved - Do Not Redistribute
#

marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

aws_nat "start monitor" do
  action :start_nat_monitor
  only_if {node[:aws][:vpc_nat][:nat_ha]=='enabled'}
end


