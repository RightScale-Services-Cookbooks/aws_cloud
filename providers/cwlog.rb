action :add do
  key = new_resource.name
  value = new_resource.file
  node.default['aws_logs']['log_groups'][key] = value

  execute "cwlogs-reconfigure" do
    command "/opt/aws/cloudwatch/awslogs-agent-setup.py -n -r us-east-1 -c /tmp/cwlogs.cfg"
    action :nothing
  end

  template "/tmp/cwlogs.cfg" do
    source "cwlogs.cfg.erb"
    owner "root"
    group "root"
    mode 0644
    backup 0
    action :create
    notifies :run, 'execute[cwlogs-reconfigure]', :delayed
  end

  new_resource.updated_by_last_action(true)
end
