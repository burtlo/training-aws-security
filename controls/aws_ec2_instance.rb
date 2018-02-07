# encoding: utf-8
# copyright: 2017, The Authors


control "aws-1" do
  impact 0.7
  title 'Checks the machine is running'

  describe aws_ec2_instance('i-0d46cd56fa5bda893') do
    it { should be_running }
    its(:public_ip_address) { should eq '34.234.67.126' }
    its(:image_id) { should eq 'ami-d5d7ffae' }
    # %w{
    #   public_ip_address private_ip_address key_name private_dns_name
    #   public_dns_name subnet_id architecture root_device_type
    #   root_device_name virtualization_type client_token launch_time
    #   instance_type image_id vpc_id
    # }.each do |name|
    #   its(name) { should eq 'value' }
    # end
  end

  #
  # SECTION: aws_ec2_instance#tags
  #

  describe aws_ec2_instance('i-0d46cd56fa5bda893') do
    its(:tags) { should include({ :key => 'Name', :value => 'jhnftz-inspec-lab-exam-env' }) }
  end

  # These are some my proposed ways in which someone
  # should test for tags on an instance
  #
  # @note https://github.com/chef/inspec-aws/issues/225
  # @note They only work because I am using my fork of the code
  describe aws_ec2_instance('i-0d46cd56fa5bda893') do
    its(:tags) { should have_tag(Name: 'jhnftz-inspec-lab-exam-env') }
    its(:tags) { should include(Name: 'jhnftz-inspec-lab-exam-env') }
    it { should have_tag(Name: 'jhnftz-inspec-lab-exam-env') }
  end

  # @note another idea on how tags could be verified
  # describe aws_ec2_instance('i-0d46cd56fa5bda893').tags do
  #   its(:Name) { should eq 'jhnftz-inspec-lab-exam-env' }
  # end


  #
  # SECTION: aws_ec2_instance#security_groups
  #

  # describe aws_ec2_instance('i-0d46cd56fa5bda893') do
  #   its(:security_groups) { should include({ id: 'sg-b88c6dcf', name: 'launch-wizard-106' }) }
  #   its(:security_groups) { should include(id: 'sg-b88c6dcf', name: 'launch-wizard-106') }
  #   # Good if there is only one security group. I believe security groups can have multiple
  #   its(:security_groups) { should cmp({ id: 'sg-b88c6dcf', name: 'launch-wizard-106' }) }
  #   its(:security_groups) { should cmp( id: 'sg-b88c6dcf', name: 'launch-wizard-106' ) }
  # end

  describe aws_ec2_instance('i-0d46cd56fa5bda893') do
    # @note this fails because the `aws_security_group` resources/helper_method is not defined in this scope.
    # its(:security_groups) { should include(aws_security_group('sg-b88c6dcf')) }

    its(:security_groups) { should have_group(id: 'sg-b88c6dcf') }
    its(:security_groups) { should have_group(name: 'launch-wizard-106') }
  end

  # describe aws_ec2_instance('i-0d46cd56fa5bda893').security_groups do
  #   it { should have_group(id: 'sg-b88c6dcf') }
  #   it { should have_group(name: 'launch-wizard-106') }
  # end

  # @note THIS DOES NOT WORK complains about id
  # describe aws_ec2_instance(name: 'i-0d46cd56fa5bda893') do
  #   it { should be_running }
  #   # it { should have_roles }
  # end
  #
  # ×  EC2 Instance i-0d46cd56fa5bda893 should be running
  #   missing required option :id
end
