case node[:platform]
when 'redhat', 'centos', 'scientific', 'fedora', 'suse', 'amazon'
  default[:aws][:cli] = '/usr/bin/aws'
when 'debian', 'ubuntu'
  default[:aws][:cli] = '/usr/local/bin/aws'
else
  fail 'OS Not Supported'
end
Chef::Log.info "Platform: #{node[:platform]}, CLI: #{node[:aws][:cli]}"
