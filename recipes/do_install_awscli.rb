
include_recipe 'python::pip'

python_pip 'awscli' do
  #version '1.3.8'
  action :install
end

aws 'create_cred_file' do
  action :create_cred_file
end

