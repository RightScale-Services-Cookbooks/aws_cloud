#
# Cookbook Name:: aws
# Recipe:: install_ec2_api_tools
#
# Copyright 2013, Rightscale Inc.
#
# All rights reserved - Do Not Redistribute
#

marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

ec2_api_tools="ec2-api-tools-1.7.1.0"
remote_file "#{Chef::Config[:file_cache_path]}/#{ec2_api_tools}.zip" do
  source "http://s3.amazonaws.com/ec2-downloads/#{ec2_api_tools}.zip"
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/#{ec2_api_tools}.zip")}
end

package "unzip"
execute "unzip #{Chef::Config[:file_cache_path]}/#{ec2_api_tools}.zip" do
  command "unzip #{Chef::Config[:file_cache_path]}/#{ec2_api_tools}.zip -d /home/"
   not_if { ::File.exists?("/home/#{ec2_api_tools}")}
end

link  "/home/ec2" do
  to "/home/#{ec2_api_tools}"
  link_type :symbolic
end

log "setup java for ec2 api tools"
package "java-1.7.0-openjdk"
execute "file $(which java)"

template "/etc/profile.d/ec2.sh" do
  source "ec2.sh.erb"
end
