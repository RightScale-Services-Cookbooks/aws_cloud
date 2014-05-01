case platform
when "redhat","centos","scientific","fedora","suse","amazon"
  default[:aws][:cli]="/usr/bin/aws"
when "debian","ubuntu"
  default[:aws][:cli]="/usr/local/bin/aws"
else
  raise "OS Not Supported"
end
