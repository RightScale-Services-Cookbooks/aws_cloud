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

action :attach do
  remote_recipe "Attach me to nat host" do
    recipe "aws::vpc-nat-ha"
#    attributes :remote_recipe => {
#      :backend_ip => new_resource.backend_ip,
#      :backend_id => new_resource.backend_id,
#    }
    recipients_tags "nat:ha=enabled"
  end
end