name             'aws'
maintainer       'RightScale Inc'
maintainer_email 'premium@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures aws'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.4'

depends "rightscale"

recipe "aws::do_install_ses", "Configures postfix to use AWS SES " 

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
