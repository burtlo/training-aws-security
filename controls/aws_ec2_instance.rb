# encoding: utf-8
# copyright: 2018, The Authors

# Webserver
describe aws_ec2_instance('i-05121225e94646a2b') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('subnet_id') { should eq 'subnet-21c8f345' }
  its('security_group_ids') { should cmp ["sg-42bfbc35", "sg-e8b6b59f"] }
end

# Database
describe aws_ec2_instance('i-01053bc7abd6c9da3') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('subnet_id') { should eq 'subnet-fcdce798' }
  its('security_group_ids') { should cmp 'sg-42bfbc35' }
end

# The VPC id is in the output
describe aws_vpc('vpc-2300d758') do
  its('state') { should eq 'available' }
  its('cidr_block') { should eq '10.0.0.0/16' }
end

# # The Subnet id is in the output
describe aws_subnet('subnet-21c8f345') do
  it { should exist }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('cidr_block') { should cmp '10.0.1.0/24' }
  its('availability_zone') { should eq 'us-east-1a' }
end


#
# The name and relative-resource approach
#

describe aws_ec2_instance(name: 'webserver') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('subnet_id') { should eq 'subnet-21c8f345' }
  its('security_group_ids') { should cmp ["sg-42bfbc35", "sg-e8b6b59f"] }
end

# Database
describe aws_ec2_instance(name: 'database') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('subnet_id') { should eq 'subnet-fcdce798' }
  its('security_group_ids') { should cmp 'sg-42bfbc35' }
end

describe aws_vpc(aws_ec2_instance(name: 'webserver').vpc_id) do
  its('state') { should eq 'available' }
  its('cidr_block') { should eq '10.0.0.0/16' }
end

describe aws_subnet(aws_ec2_instance(name: 'webserver').subnet_id) do
  it { should exist }
  its('vpc_id') { should eq aws_ec2_instance(name: 'webserver').vpc_id }
  its('cidr_block') { should cmp '10.0.1.0/24' }
  its('availability_zone') { should eq 'us-east-1a' }
end
