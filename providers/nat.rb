action :start_nat_monitor do
  bash "start nat_monitor.sh" do
    user "root"
    cwd "/root"
    code <<-EOH
  pkill nat-monitor > /dev/null
  /root/nat-monitor.sh >> /var/log/nat-monitor.log 2>&1 &
    EOH
  end

end

action :stop_nat_monitor do
  bash "stop nat-monitor.sh" do
    user "root"
    cwd "/root"
    code <<-EOH
  pkill nat-monitor > /dev/null
    EOH
  end
end


# run remote recipe on opposite nat server 
# send sever_ip and server_id of local server.
action :setup_nat_monitor do
  log "Test if JAVA_HOME is set properly."
  execute "#{node[:aws][:vpc_nat][:java_home]}/bin/java -version" do
    action :run
  end

  raise "AWS Creds are not setup.  Set aws/vpc_nat/aws_account_id and "+ 
    "aws/vpc_nat/aws_account_secret" unless node[:aws][:vpc_nat][:aws_account_id]
  
  log "NAT HA enabled.  Proceding to install nat-monitor"  
  
  template "/root/nat-monitor.sh" do
    source "nat-monitor.erb"
    owner  "root"
    group  "root"
    mode   "0700"
    variables( :other_instance_id=> new_resource.server_id,
      :my_instance_id=> node[:ec2][:instance_id],
      :other_instance_ip=>  new_resource.server_ip,
      :ec2_url => node[:aws][:vpc_nat][:ec2_url],
      :java_home => node[:aws][:vpc_nat][:java_home]
    )
    action :create
  end
  
  
  template "/root/.awscreds" do
    source "credentials.erb"
    owner  "root"
    group  "root"
    mode   "0400"
    variables( :key=> node[:aws][:vpc_nat][:aws_account_id],
      :secret=>node[:aws][:vpc_nat][:aws_account_secret]
    )
    action :create
  end

  # not sure if this will every take affect
  bash "install cron to run on reboot" do
    user "root"
    cwd "/root"
    code <<-EOH
  echo '@reboot /root/nat-monitor.sh > /var/log/nat-monitor.log 2>&1' | crontab
    EOH
  end

  aws_nat "start monitor" do
    action :start_nat_monitor
  end
  
end

