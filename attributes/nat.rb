case node[:cloud][:provider]
when "ec2"
  # these will fail if the server is not in a VPC.
  set[:aws][:vpc_nat][:ec2_mac]=ENV['EC2_MAC'].blank? ? nil:ENV['EC2_MAC'].gsub(":","_").upcase
  set[:aws][:vpc_nat][:vpc_ipv4_cidr_block] =ENV['EC2_MAC'].blank? ? "0.0.0.0/0":ENV["EC2_NETWORK_INTERFACES_MACS_#{node[:aws][:vpc_nat][:ec2_mac]}_VPC_IPV4_CIDR_BLOCK"]
  set[:aws][:vpc_nat][:ec2_url]= "https://ec2.#{ENV['EC2_PLACEMENT_AVAILABILITY_ZONE'][0..-2]}.amazonaws.com"
when "vagrant"
  #this set is used for testing on Vagrant
  set[:aws][:vpc_nat][:ec2_mac]="00:00:00"
  set[:aws][:vpc_nat][:vpc_ipv4_cidr_block] ="10.0.0.0/16"
  set[:aws][:vpc_nat][:ec2_url]= "https://ec2.us-west.amazonaws.com"
end

