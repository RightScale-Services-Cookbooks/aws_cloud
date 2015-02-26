name             'aws'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures AWS '
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.2'

depends "rightscale"
depends "python"
depends "sysctl"
depends "marker"
depends "fog"

recipe "aws::do_install_ses", "Configures postfix to use AWS SES " 
recipe "aws::vpc-nat", "Enable AWS VPC NAT server ipforwarding and iptables"
recipe "aws::vpc-nat-ha", "Configures NAT Monitor for NAT server HA."
recipe "aws::start-nat-monitor", "Start NAT monitor"
recipe "aws::stop-nat-monitor", "Stop NAT monitor"
recipe "aws::do_install_awscli", "installs aws cli"
recipe "aws::install_ec2_api_tools", "install the ec2_api_tools"
recipe "aws::lb_connect", "connects to lb"
recipe "aws::lb_disconnect", "disconnects from lb"

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
  :required => "required"

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

attribute "vpc_nat/other_instance_id",
  :display_name => "Instance ID of other NAT HA Instance",
  :description => "The instance ID of the instance to monitor. Required when vpc_nat/ha is enabled",
  :required => "optional",
  :recipes => [ "aws::vpc-nat-ha" ]

attribute "vpc_nat/other_route_id",
  :display_name => "VPC Route Table Id of the other HA server",
  :description => "The VPC Route Table Id where the other instance is associated.
  Required when vpc_nat/ha is enabled. Example: rtb-ea765f83",
  :required => "optional",
  :recipes => [ "aws::vpc-nat-ha" ]

attribute "vpc_nat/route_id",
  :display_name => "VPC Route Table Id of this server",
  :description => "The VPC Route Table Id where this server is associated. 
Required when vpc_nat/ha is enabled. Example: rtb-7a019112",
  :required => "optional",
  :recipes => [ "aws::vpc-nat-ha" ]


attribute "vpc_nat/nat_ha",
  :display_name => "VPC  NAT High Availablity",
  :description => "With two NAT servers enable NAT HA.  Set to enabled if you are 
using two NAT servers in one VPC.  Default is disabled.",
  :choice=>["enabled",'disabled'],
  :default=>"disabled",
  :required => "optional",
  :recipes => [ "aws::vpc-nat-ha",
  "aws::start-nat-monitor" ]

attribute "vpc_nat/java_home",
  :display_name => "Override the JAVA_HOME path",
  :description => "JAVA is used for ec2 cli commands.  Use this input to override the default JAVA_HOME path",
  :required => "optional",
  :recipes => [ "aws::vpc-nat-ha"]

attribute "aws/lb/node_id",
  :display_name => "AWS Instance ID",
  :description => "AWS Instance ID to Connect",
  :required => "required",
  :recipes => [ "aws::lb_connect", "aws::lb_disconnect" ]

attribute "aws/lb/name",
  :display_name => "AWS ELB Name",
  :description => "AWS ELB Name",
  :required => "required",
  :recipes => [ "aws::lb_connect", "aws::lb_disconnect" ]
