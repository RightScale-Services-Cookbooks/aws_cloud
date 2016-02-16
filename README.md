aws Cookbook
============
This cookbook is to manage installation of AWS specific components for use with RightScale Cloud Management



Requirements
------------
* python cookbook 
* marker cookbook
* fog cookbook
* java cookbook

Attributes
----------
* aws/aws_access_key_id - aws access key for 
* aws/aws_secret_access_key - aws secret access key
* aws/region - the aws region.  example: us-east, or us-west-2
* aws/lb/node_id - the ec2 instance id
* aws/lb/name - the name of the ELB 

Recipes
-----
* do_install_awscli - installs the aws cli tools
* install_ec2_api_tools - installs the ecs api tools
* lb_connect - adds an instance to an ELB
* lb_disconnect - removes an instance from and ELB

Contributing
------------
If this is a public cookbook, detail the process for contributing. 

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------

