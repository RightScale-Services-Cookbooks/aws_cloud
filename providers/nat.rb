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
action :attach do
remote_recipe "Attach me to nat host" do
  recipe "aws::vpc-nat-ha"
  attributes :remote_recipe => {
    :server_id => new_resource.server_id,
    :server_ip => new_resource.server_ip
  }
  recipients_tags "nat:ha=active"
end
end
