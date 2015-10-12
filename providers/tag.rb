require 'mixlib/shellout'
action :get do
  Chef::Log.info 'not implemented yet'
  new_resource.updated_by_last_action(true)
end

action :set do
  key = new_resource.name
  value = new_resource.value
  resources = new_resource.resources
  aws 'create cred' do
    action :create_cred_file
  end
  cmd = "#{node[:aws][:cli]} ec2 create-tags --resources #{resources} --tags Key=#{key},Value=#{value}"
  result = Mixlib::ShellOut.new(cmd).run_command
  Chef::Log.info "cmd:#{cmd}, STDOUT:#{result.stdout}, STDERR:#{result.stderr}"
  result.error!
  aws 'cleanup creds' do
    action :delete_cred_file
  end
  new_resource.updated_by_last_action(true)
end
