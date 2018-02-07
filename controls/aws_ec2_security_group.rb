RSpec::Matchers.define :permit do |expected|
  match do |rules|
    rules.find do |rule|
      # TODO: port for singular and port range
      # TODO: source for singular and source for range
      expected[:port] == rule.port &&
      expected[:protocol].to_s == rule.protocol.to_s &&
      expected[:source] == rule.source
      # TODO: optionally match description
    end
  end

  description do
    # TODO: port for singular and port range
    # TODO: source for singular and source for range
    "permit #{expected[:protocol].upcase} traffic on port #{expected[:port]} from source #{expected[:source]}"
  end
end

# TODO: Create a Matcher class of the above and make this a special version of it.
RSpec::Matchers.define :permit_all_traffic do |expected|
  match do |rules|
    rules.find do |rule|
      # TODO: port for singular and port range
      # TODO: source for singular and source for range
      # @note A nil is in the example when it is set to all traffic
      rule.port.nil? &&
      # @note a -1 means all types of protocols
      '-1' == rule.protocol.to_s &&
      '0.0.0.0/0' == rule.source
      # TODO: optionally match description
    end
  end

  description do
    # TODO: port for singular and port range
    # TODO: source for singular and source for range
    "permit ALL traffic on ALL port from ALL sources"
  end
end



describe aws_ec2_security_group(id: 'sg-b88c6dcf') do
  it { should exist }
  its('inbound.rules') { should permit({ protocol: :tcp, port: 22, source: '0.0.0.0/0' }) }
  its('outbound.rules') { should permit_all_traffic }
end

# The data structure from the AWS Ruby client
# ip_permissions=
#  [#<struct Aws::EC2::Types::IpPermission
#    from_port=22,
#    ip_protocol="tcp",
#    ip_ranges=
#     [#<struct Aws::EC2::Types::IpRange
#       cidr_ip="0.0.0.0/0",
#       description=nil>],
#    ipv_6_ranges=[],
#    prefix_list_ids=[],
#    to_port=22,
#    user_id_group_pairs=[]>],
# owner_id="404885260443",
# group_id="sg-b88c6dcf",
# ip_permissions_egress=
#  [#<struct Aws::EC2::Types::IpPermission
#    from_port=nil,
#    ip_protocol="-1",
#    ip_ranges=
#     [#<struct Aws::EC2::Types::IpRange
#       cidr_ip="0.0.0.0/0",
#       description=nil>],
#    ipv_6_ranges=[],
#    prefix_list_ids=[],
#    to_port=nil,
#    user_id_group_pairs=[]>],

# @note this command returns so many more things that are not available on an InSpec resource `aws_ec2_security_group`
#
# $ aws ec2 describe-security-groups --group-ids sg-b88c6dcf
# {
#     "SecurityGroups": [
#         {
#             "Description": "launch-wizard-106 created 2018-01-25T11:44:52.959+00:00",
#             "GroupName": "launch-wizard-106",
#             "IpPermissions": [
#                 {
#                     "FromPort": 22,
#                     "IpProtocol": "tcp",
#                     "IpRanges": [
#                         {
#                             "CidrIp": "0.0.0.0/0"
#                         }
#                     ],
#                     "Ipv6Ranges": [],
#                     "PrefixListIds": [],
#                     "ToPort": 22,
#                     "UserIdGroupPairs": []
#                 }
#             ],
#             "OwnerId": "404885260443",
#             "GroupId": "sg-b88c6dcf",
#             "IpPermissionsEgress": [
#                 {
#                     "IpProtocol": "-1",
#                     "IpRanges": [
#                         {
#                             "CidrIp": "0.0.0.0/0"
#                         }
#                     ],
#                     "Ipv6Ranges": [],
#                     "PrefixListIds": [],
#                     "UserIdGroupPairs": []
#                 }
#             ],
#             "VpcId": "vpc-d11531b4"
#         }
#     ]
# }
