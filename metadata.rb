name             'aws'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures AWS '
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.5'

depends "rightscale"

recipe "aws::do_install_ses", "Configures postfix to use AWS SES " 
recipe "aws::vpc-nat", "Enable AWS VPC NAT instance ipforwarding and iptables"
recipe "aws::vpc-nat-ha", "Configures NAT Monitor for NAT instance HA."
recipe "aws::start-nat-monitor", "Start NAT monitor"
recipe "aws::stop-nat-monitor", "Stop NAT monitor"

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

attribute "aws/vpc_nat/other_instance_id",
  :display_name => "Instance ID of other NAT HA Instance",
  :description => "The instance ID of the instance to monitor.",
  :required => "required",
  :recipes => [ "aws::vpc-nat-ha" ]

attribute "aws/vpc_nat/other_route_id",
  :display_name => "VPC Route Table Id of the other HA server",
  :description => "The VPC Route Table Id where the other instance is associated. Example: rtb-ea765f83",
  :required => "required",
  :recipes => [ "aws::vpc-nat-ha" ]

attribute "aws/vpc_nat/route_id",
  :display_name => "VPC Route Table Id of this server",
  :description => "The VPC Route Table Id where this server is associated.  Example: rtb-7a019112",
  :required => "required",
  :recipes => [ "aws::vpc-nat-ha" ]

attribute "aws/vpc_nat/aws_account_id",
  :display_name => "AWS Account Id ",
  :description => "Use your Amazon access key ID (e.g., cred:AWS_ACCESS_KEY_ID)",
  :required => "required",
  :recipes => [ "aws::vpc-nat-ha" ]

attribute "aws/vpc_nat/aws_account_secret",
  :display_name => "AWS Account Secret Key",
  :description => "Use your AWS secret access key (e.g., cred:AWS_SECRET_ACCESS_KEY)",
  :required => "required",
  :recipes => [ "aws::vpc-nat-ha" ]

attribute "aws/vpc_nat/nat_ha",
  :display_name => "VPC NAT High Availablity",
  :description => "With two NAT servers enable NAT HA.  Set to enabled if you are 
using two NAT servers in one VPC.  Default is disabled.",
  :choice=>["enabled",'disabled'],
  :required => "required",
  :recipes => [ "aws::vpc-nat-ha",
  "aws::start-nat-monitor" ]

attribute "aws/vpc_nat/java_home",
  :display_name => "Override the JAVA_HOME path",
  :description => "JAVA is used for ec2 cli commands.  Use this input to override the default JAVA_HOME path",
  :required => "optional",
  :recipes => [ "aws::vpc-nat-ha"]