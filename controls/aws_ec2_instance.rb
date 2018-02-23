# encoding: utf-8
# copyright: 2018, The Authors

# Attribute file  example
# $ inspec exec . --attrs attributes.yml -t aws://us-east-1
# webserver_id = attribute('ec2_instance.webserver', description: 'webserver id')


# Profile file example
# content = inspec.profile.file("terraform.json")
# params = JSON.parse(content)
# webserver_id = params['ec2_instance.webserver']['value']

# Webserver
# @note I didn't use the name because https://github.com/chef/inspec/issues/2736
describe aws_ec2_instance('i-004807f12125d2437') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-6c65b317' }
  its('subnet_id') { should eq 'subnet-6d417b09' }
  its('security_group_ids') { should cmp ["sg-b5eee0c2", "sg-36d3dd41"] }
end

# Database
describe aws_ec2_instance('i-027f44ba53fc8f37e') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-6c65b317' }
  its('subnet_id') { should eq 'subnet-7d447e19' }
  its('security_group_ids') { should cmp ["sg-8bd1dffc", "sg-36d3dd41"] }
end

# The VPC id is in the output
describe aws_vpc('vpc-6c65b317') do
  its('state') { should eq 'available' }
  its('cidr_block') { should eq '10.0.0.0/16' }
end

# The Subnet id is in the output
describe aws_subnet('subnet-6d417b09') do
  it { should exist }
  its('vpc_id') { should eq 'vpc-6c65b317' }
  its('cidr_block') { should cmp '10.0.1.0/24' }
  its('availability_zone') { should eq 'us-east-1a' }
end

describe aws_subnet('subnet-7d447e19') do
  it { should exist }
  its('vpc_id') { should eq 'vpc-6c65b317' }
  its('cidr_block') { should cmp '10.0.100.0/24' }
  its('availability_zone') { should eq 'us-east-1a' }
end

describe aws_security_group('sg-b5eee0c2') do
  it { should exist }
end

describe aws_security_group('sg-36d3dd41') do
  it { should exist }
end

describe aws_security_group('sg-8bd1dffc') do
  it { should exist }
end
