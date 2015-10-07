#
# Cookbook Name:: aws
# Recipe:: stop-nat-monitor
#
# Copyright 2013, Rightscale Inc.
#
# All rights reserved - Do Not Redistribute
#

marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

aws_nat 'stop nat monitor' do
  action :stop_nat_monitor
end
