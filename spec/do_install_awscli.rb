require 'spec_helper'

describe 'aws::do_install_awscli' do
  
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with( 'python::pip')
  end


  let(:chef_run) { ChefSpec::Runner.new().converge(described_recipe) }

  
  it "install cli" do
    expect(chef_run).to install_python_pip("awscli")
  end
  
  it "create creds file" do
    expect(chef_run).to create_cred_file_aws("create_cred_file")
  end
end