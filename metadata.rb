name             'aws'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures AWS '
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.7'

depends "rightscale"
depends "python"
depends "sysctl"
#depends "java"

recipe "aws::do_install_ses", "Configures postfix to use AWS SES " 
recipe "aws::vpc-nat", "Enable AWS VPC NAT instance ipforwarding and iptables"
recipe "aws::vpc-nat-ha", "Configures NAT Monitor for NAT instance HA."
recipe "aws::start-nat-monitor", "Start NAT monitor"
recipe "aws::stop-nat-monitor", "Stop NAT monitor"
recipe "aws::do_install_awscli", "installs aws cli"

attribute "aws/aws_access_key_id",
  :display_name => "AWS_ACCESS_KEY_ID",
  :description => "Use your Amazon access key ID (e.g., cred:AWS_ACCESS_KEY_ID)",
  :required => "required"

attribute "aws/aws_secret_access_key",
  :display_name => "AWS_SECRET_ACCESS_KEY",
  :description => "Use your AWS secret access key (e.g., cred:AWS_SECRET_ACCESS_KEY)",
  :required => "required"

attribute "aws/region",
  :display_name => "AWS Region",
  :description => "AWS Region",
  :required => "required",
  :recipes => [ "aws::do_install_awscli" ]

attribute "aws/ses/username", 
  :display_name => "SES Username",
  :description => "SES Username",
  :required => "required",
  :recipes => [ "aws::do_install_ses" ]

attribute "aws/ses/password",
  :display_name => "SES password",
  :description => "SES password",
  :required => "required",
  :recipes => [ "aws::do_install_ses" ]

attribute "aws/ses/server", 
  :display_name => "SES Server",
  :description => "SES Server",
  :required => "required",
  :recipes => [ "aws::do_install_ses" ]

attribute "aws/ses/domain",
  :display_name => "SES domain",
  :description => "SES domain",
  :required => "required",
  :recipes => [ "aws::do_install_ses" ]

attribute "aws/ses/virtual_alias_domains",
  :display_name => "SES Virtual Alias Domain",
  :description => "SES Virtual Alias Domain",
  :type => "array",
  :required => "required",
  :recipes => [ "aws::do_install_ses" ]



attribute "aws/vpc_nat/aws_account_id",
  :display_name => "AWS Account Id ",
  :description => "Use your Amazon access key ID (e.g., cred:AWS_ACCESS_KEY_ID).  Required for NAT HA",
  :required => "optional",
  :recipes => [ "aws::vpc-nat-ha" ]

attribute "aws/vpc_nat/aws_account_secret",
  :display_name => "AWS Account Secret Key",
  :description => "Use your AWS secret access key (e.g., cred:AWS_SECRET_ACCESS_KEY). Required for NAT HA",
  :required => "optional",
  :recipes => [ "aws::vpc-nat-ha" ]

attribute "aws/vpc_nat/nat_ha",
  :display_name => "VPC NAT High Availablity",
  :description => "With two NAT servers enable NAT HA.  Set to enabled if you are 
using two NAT servers in one VPC. When set to enabled, also set optional inputs route_id, 
other_route_id, and other_instance_id. Default is disabled. ",
  :choice=>["enabled",'disabled'],
  :required => "required",
  :recipes => ["aws::vpc-nat", "aws::vpc-nat-ha","aws::start-nat-monitor" ]
