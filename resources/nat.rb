actions :start_nat_monitor, :stop_nat_monitor, :setup_nat_monitor
default_action :start_nat_monitor

attribute :server_ip, :kind_of => String, :default => ""
attribute :server_id, :kind_of => String, :default => ""
