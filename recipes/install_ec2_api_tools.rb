#
# Cookbook Name:: aws
# Recipe:: install_ec2_api_tools
#
# Copyright 2013, Rightscale Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

#http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
remote_file "#{Chef::Config[:file_cache_path]}/ec2-api-tools.zip" do
  source "http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip"
  not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/ec2-api-tools.zip") }
end

package 'unzip'
execute "unzip #{Chef::Config[:file_cache_path]}/ec2-api-tools.zip" do
  command "unzip #{Chef::Config[:file_cache_path]}/ec2-api-tools.zip -d /home/"
  not_if { ::File.exist?("/home/ec2-api-tools.zip") }
end

link '/home/ec2' do
  to "/home/ec2-api-tools.zip"
  link_type :symbolic
end

log 'setup java for ec2 api tools'
execute 'file $(which java)'

template '/etc/profile.d/ec2.sh' do
  source 'ec2.sh.erb'
end
