default[:cwlogs][:logfile] = '/var/log/aws/opsworks/opsworks-agent.log'
default['aws_logs']['log_groups'] = Hash.new
default['aws_logs']['log_groups']['messages']='/var/log/messages'
default['aws_logs']['log_groups']['secure']='/var/log/secure'
