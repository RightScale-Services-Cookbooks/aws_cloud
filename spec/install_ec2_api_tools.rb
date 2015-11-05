require 'spec_helper'

describe 'aws::install_ec2_api_tools' do

  let(:chef_run) { ChefSpec::Runner.new().converge(described_recipe) }
 # let(:ec2_api_tools){"ec2-api-tools-1.7.1.0"}
  
  it "remote file" do
    expect(chef_run).to \
      create_remote_file("#{Chef::Config[:file_cache_path]}/ec2-api-tools.zip")
  end
  
  it "package unzip" do
    expect(chef_run).to install_package("unzip")
  end
  
  it "execute unzip" do
    expect(chef_run).to run_execute("unzip #{Chef::Config[:file_cache_path]}/ec2-api-tools.zip")
  end
  
  it "link" do
    expect(chef_run).to create_link("/home/ec2").with(link_type: Symbol)
  end
  
  it "include recipe java" do
    expect(chef_run).to include_recipe('java')
  end
  
  it "execute which java" do
    expect(chef_run).to run_execute("file $(which java)")
  end
  
  it "execute /etc/profile.d/ec2.sh" do
    expect(chef_run).to create_template("/etc/profile.d/ec2.sh")
  end
  
  it "log" do
     expect(chef_run).to write_log('setup java for ec2 api tools')
  end
end