require 'spec_helper'

describe 'aws::lb_connect' do
  

  let(:chef_run) { 
    ChefSpec::Runner.new do |node|
      node.set[:aws][:lb][:node_id] = 'hello'
      node.set[:aws][:lb][:node_id] = 'hello'
    end.converge(described_recipe) 
  
  }

  it "include fog" do
    expect(chef_run).to include_recipe 'fog::default'
  end
  
  it "lb connect" do
    expect(chef_run).to connect_aws_lb('connect to lb')
  end
end