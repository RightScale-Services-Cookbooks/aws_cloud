require 'mixlib/shellout'
action :get do
  Chef::Log.info "not implemented yet"
end

action :set do
  key=new_resource.name
  value=new_resource.value
  resources=new_resource.resources
  cmd="/usr/bin/aws ec2 create-tags --resources #{resources} --tags Key=#{key},Value=#{value}"
  result=Mixlib::ShellOut.new(cmd).run_command
  Chef::Log.info "cmd:#{cmd}, STDOUT:#{result.stdout}, STDERR:#{result.stderr}"
  result.error!
end
