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
remote_file "/tmp/#{ec2_api_tools}.zip" do
  source "http://s3.amazonaws.com/ec2-downloads/#{ec2_api_tools}.zip"
  not_if { ::File.exists?("/tmp/#{ec2_api_tools}.zip")}
end

directory "/home/ec2" do
  action :create
end

package "unzip"
execute "unzip /tmp/#{ec2_api_tools}.zip" do
  command "unzip /tmp/#{ec2_api_tools}.zip -d /home/ec2"
   not_if { ::File.exists?("/home/ec2/#{ec2_api_tools}")}
end



log "setup java for ec2 api tools"
package "java"
execute "file $(which java)"


bash "ec2 environment file" do
  code <<-EOH
  cat >> /etc/profile.d/ec2.sh << eof
  export PATH=/home/ec2/#{ec2_api_tools}/bin:${PATH}
  export EC2_HOME=/home/ec2/#{ec2_api_tools}
  eof
  file $(which java)
  EOH
end


