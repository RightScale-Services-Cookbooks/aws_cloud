#
# Cookbook Name:: aws
# Recipe:: vpc-nat
#
# Copyright 2013, Rightscale Inc.
#
# All rights reserved - Do Not Redistribute
#

marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

if node[:vpc_nat][:vpc_ipv4_cidr_block]
  template '/etc/iptables.snat' do
    source 'iptables.snat.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(cidr: node[:vpc_nat][:vpc_ipv4_cidr_block])
    action :create
  end
else
  fail '*** node[:vpc_nat][:vpc_ipv4_cidr_block], defined in attributes/default.rb is empty'
end

sysctl 'net.ipv4.ip_forward' do
  value '1'
  action :set
end

sysctl 'net.ipv4.conf.eth0.send_redirects' do
  value '0'
  action :set
end

# sys_firewall::default disables iptables when node[:sys_firewall][:enabled]==disabled
bash 'iptables-restore' do
  flags '-ex'
  user 'root'
  cwd '/tmp'
  code <<-EOH
    if [ -f "/etc/iptables.snat" ]; then
      iptables-restore < /etc/iptables.snat
    fi
  EOH
end
