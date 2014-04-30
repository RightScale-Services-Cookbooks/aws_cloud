action :create_cred_file do
  template "/root/.aws/config" do
    source "aws_config.erb"
    owner "root"
    group "root"
    mode "0600"
    variables( :aws_access_key_id => node[:aws][:aws_access_key_id],
               :aws_secret_access_key => node[:aws][:aws_secret_access_key],
               :aws_region  => node[:aws][:region] )
    action :create
  end
end

action :delete_cred_file do
  file "/root/.aws/config" do
    backup false
    action :delete
  end
end
