name 'fake'
maintainer 'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license 'Apache 2.0'
description 'Installs/Configures a test tools'
version '0.1.0'

depends 'aws'
depends 'fog'

recipe 'fake::lb_connect', 'fakes a elb connect'
recipe 'fake::lb_disconnect', 'fakes a elb disconnect'