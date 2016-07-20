Chef::Log.info "Chef Log Group Name #{node['aws_logs']['log_group_name']}"
log_group_name = node['aws_logs']['log_group_name'].gsub!(/\s+/, '-').gsub!(/#/,'').gsub!(/-+/,'-')

directory "/root/.aws" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

template "/root/.aws/credentials" do
  source "credentials.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :aws_secret_access_key => node['aws_logs']['aws_secret_access_key'],
    :aws_access_key_id => node['aws_logs']['aws_access_key_id']
  )
  action :create
end

directory "/opt/aws/cloudwatch" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
end

template "/tmp/cwlogs.cfg" do
  source "cwlogs.cfg.erb"
  owner "root"
  group "root"
  mode 0644
  variables(:log_group_name => log_group_name )
  action :create
end

remote_file "/opt/aws/cloudwatch/awslogs-agent-setup.py" do
  owner "root"
  group "root"
  source "https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py"
  mode "0755"
  action :create
end

execute "Install CloudWatch Logs agent" do
  command "/opt/aws/cloudwatch/awslogs-agent-setup.py -n -r us-east-1 -c /tmp/cwlogs.cfg"
  not_if { system "pgrep -f aws_logs-agent-setup" }
end
