name 'aws'
maintainer 'RightScale Inc'
maintainer_email 'ps@rightscale.com'
license 'Apache 2.0'
description 'Installs/Configures AWS '
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.0'

depends 'python'
depends 'marker'
depends 'fog'
depends 'java'

recipe 'aws::default', 'installs aws tools'
recipe 'aws::do_install_awscli', 'installs aws cli'
recipe 'aws::install_ec2_api_tools', 'install the ec2_api_tools'
recipe 'aws::lb_connect', 'connects to lb'
recipe 'aws::lb_disconnect', 'disconnects from lb'

attribute 'aws/aws_access_key_id',
          display_name: 'AWS_ACCESS_KEY_ID',
          description: 'Use your Amazon access key ID (e.g., cred:AWS_ACCESS_KEY_ID)',
          required: 'required'

attribute 'aws/aws_secret_access_key',
          display_name: 'AWS_SECRET_ACCESS_KEY',
          description: 'Use your AWS secret access key (e.g., cred:AWS_SECRET_ACCESS_KEY)',
          required: 'required'

attribute 'aws/region',
          display_name: 'AWS Region',
          description: 'AWS Region',
          required: 'required'

attribute 'aws/lb/node_id',
          display_name: 'AWS Instance ID',
          description: 'AWS Instance ID to Connect',
          required: 'required',
          recipes: ['aws::lb_connect', 'aws::lb_disconnect']

attribute 'aws/lb/name',
          display_name: 'AWS ELB Name',
          description: 'AWS ELB Name',
          required: 'required',
          recipes: ['aws::lb_connect', 'aws::lb_disconnect']
