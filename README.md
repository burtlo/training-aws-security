# Chef Training AWS InSpec Profile

Exploring defining a profile and testing out AWS resources using inspec-aws.

## Setup

1. Install Terraform

Terraform enables you to provision infrastructure in the cloud. It does this through a template file that describes the desired configuration. A terraform file has been provided within the profile that will setup the environment that this InSpec profile will verify

```shell
$ git clone REPO
```

Now move into the project directory.

```shell
$ cd REPO
```

Terraform provides support for a large variety of cloud vendors. The terraform tool does not come with all of these provider specific tools installed. Run the `init` subcommand.

```shell
$ terraform init


Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.9.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.9"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Terraform installs the AWS provider driver based on the terraform templates that it found within the current directory.

Run the `plan` subcommand to have Terraform generate a proposed plan of execution.

```shell
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

[...]

Plan: 9 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

Displayed is a calculated proposal of all the resources Terraform would create if the plan would be applied. Assuming you have not setup this environment before, the results show that is is going to create for you the entire application defined in the plan file.

Before moving forward and applying this plan first create a workspace. Since Terraform works within a single directory on the plan files within the directory you will want to create a workspace. When the plan is applied the results of the application will be stored in only this workspace. This is useful as it will store the resulting ids and other values necessary to describe the infrastructure it deploys into AWS.

Create a new workspace by running the `workspace new` subcommand.

```shell
$ terraform workspace new learn-chef
Created and switched to workspace "learn-chef"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
```

You can see your current workspace and the other defined workspaces with the `workspace list` subcommand.

```shell
$ terraform workspace list
  default
* learn-chef
```

The current workspace, `learn-chef`, is denoted with a star. The other workspaces appear alphabetically alongside it.

Now that you are within this workspace, run the `apply` subcommand.

```shell
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

[...]

Plan: 9 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

This output is similar to the output you saw when you ran the `plan` subcommand with the addition of a prompt asking you to approve the application of the plan. Enter the value `yes` to create the plan.

```shell
  Enter a value: yes

  aws_vpc.default: Creating...

  [...]

  Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

  Outputs:

  ec2_instance.database = i-027f44ba53fc8f37e
  ec2_instance.database.name = database
  ec2_instance.database.ami = ami-d5d7ffae
  ec2_instance.database.instance_type = t1.micro
  ec2_instance.database.private_ip = 10.0.100.175
  ec2_instance.webserver = i-004807f12125d2437
  ec2_instance.webserver.ami = ami-d5d7ffae
  ec2_instance.webserver.instance_type = t1.micro
  ec2_instance.webserver.name = webserver
  ec2_instance.webserver.public_ip = 35.153.60.86
  route.internet_access.id = r-rtb-c7f40cbb1080289494
  security_group.ssh.id = sg-36d3dd41
  security_group.web.id = sg-b5eee0c2
  subnet.private.id = subnet-7d447e19
  subnet.public.id = subnet-6d417b09
  vpc.id = vpc-6c65b317
```

The terraform plan finishes deployment and reports the resources that it has created.

Run the `plan` subcommand.

```shell
$ terraform apply
aws_vpc.default: Refreshing state... (ID: vpc-6c65b317)
aws_security_group.ssh: Refreshing state... (ID: sg-36d3dd41)
aws_security_group.web: Refreshing state... (ID: sg-b5eee0c2)
aws_subnet.public: Refreshing state... (ID: subnet-6d417b09)
aws_subnet.private: Refreshing state... (ID: subnet-7d447e19)
aws_internet_gateway.default: Refreshing state... (ID: igw-34e8154c)
aws_security_group.mysql: Refreshing state... (ID: sg-8bd1dffc)
aws_route.internet_access: Refreshing state... (ID: r-rtb-c7f40cbb1080289494)
aws_instance.webserver: Refreshing state... (ID: i-004807f12125d2437)
aws_instance.database: Refreshing state... (ID: i-027f44ba53fc8f37e)

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

ec2_instance.database = i-027f44ba53fc8f37e
ec2_instance.database.name = database
ec2_instance.database.ami = ami-d5d7ffae
ec2_instance.database.instance_type = t1.micro
ec2_instance.database.private_ip = 10.0.100.175
ec2_instance.webserver = i-004807f12125d2437
ec2_instance.webserver.ami = ami-d5d7ffae
ec2_instance.webserver.instance_type = t1.micro
ec2_instance.webserver.name = webserver
ec2_instance.webserver.public_ip = 35.153.60.86
route.internet_access.id = r-rtb-c7f40cbb1080289494
security_group.ssh.id = sg-36d3dd41
security_group.web.id = sg-b5eee0c2
subnet.private.id = subnet-7d447e19
subnet.public.id = subnet-6d417b09
vpc.id = vpc-6c65b317
```

Recall that when you ran the `plan` subcommand it displayed a list of resources that it would create for you. Now Terraform will evaluate the requirements of the plan against the current state of the application.

Run the `output` subcommand.

```shell
$ terraform output
ec2_instance.database = i-027f44ba53fc8f37e
ec2_instance.database.name = database
ec2_instance.database.ami = ami-d5d7ffae
ec2_instance.database.instance_type = t1.micro
ec2_instance.database.private_ip = 10.0.100.175
ec2_instance.webserver = i-004807f12125d2437
ec2_instance.webserver.ami = ami-d5d7ffae
ec2_instance.webserver.instance_type = t1.micro
ec2_instance.webserver.name = webserver
ec2_instance.webserver.public_ip = 35.153.60.86
route.internet_access.id = r-rtb-c7f40cbb1080289494
security_group.ssh.id = sg-36d3dd41
security_group.web.id = sg-b5eee0c2
subnet.private.id = subnet-7d447e19
subnet.public.id = subnet-6d417b09
vpc.id = vpc-6c65b317
```

This displays the output values from the application that was created. Time to write a control that ensures that this webserver and the database are running:

Remove the `controls/example.rb`.

Create a `controls/instances.rb` with the content:

```ruby
describe aws_ec2_instance(name: 'webserver') do
  it { should be_running }
end

describe aws_ec2_instance('i-027f44ba53fc8f37e') do
  it { should be_running }
end
```

The `aws_ec2_instance` control will find the instance with a specified id or name. The id is provided automatically by AWS and reported back in the output results you saw before. The `name` is defined in a tag specified on the instance (i.e. tag Name). The tests verify that the instances are running.

Now it is time to perform a scan with this profile. Recall that when you execute a scan you specify a target. This target has traditionally been a protocol with the system and the required credentials. InSpec is able to also target cloud providers as a target using `aws://REGION`.

Execute a scan with this profile targeting the AWS platform in the us-east-1 region.

```shell
$ inspec exec PROFILE -t aws://us-east-1

Profile: InSpec Profile (training-aws-security)
Version: 0.1.0
Target:  aws://us-east-1

  EC2 Instance webserver
     ✔  should be running
  EC2 Instance i-01053bc7abd6c9da3
     ✔  should be running

Test Summary: 2 successful, 0 failures, 0 skipped
```

The results of the scan show that the two instances are running.

Asserting that the instance is running is a great start but it does not ensure that it was built from the correct image and running on the correct size instance.

This instance in us-east-1 is using the AMI with the id `ami-d5d7ffae` and for the size `t1.micro`. Note: these values are defined in the terraform plan and appeared when you ran `terraform output`

Update the control defined to include tests to verify the instance AMI and type.

```ruby
describe aws_ec2_instance(name: 'webserver') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
end

# Database
describe aws_ec2_instance(name: 'database') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
end
```

REFERENCE: https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Subnets.html

The instance is deployed into a virtual private cloud (VPC). This ensures that the instance is not on the same network with other systems within Amazon or your other applications unless you explicitly have them join that VPC. A VPC defines a supported list of IP addresses within this internal network.

```ruby
describe aws_ec2_instance(name: 'webserver') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
end

describe aws_ec2_instance(name: 'database') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
end

describe aws_vpc('vpc-2300d758') do
  its('state') { should eq 'available' }
  its('cidr_block') { should eq '10.0.0.0/16' }
end
```

Within a VPC a subnet is defined. This subnet is smaller sub-section of the network defined by the VPC. It is defined in one availability zone. This subnet defines a specific range of network addresses.

```ruby
describe aws_ec2_instance(name: 'webserver') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('subnet_id') { should eq 'subnet-21c8f345' }
end

describe aws_ec2_instance(name: 'database') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('subnet_id') { should eq 'subnet-fcdce798' }
end

describe aws_vpc('vpc-2300d758') do
  its('state') { should eq 'available' }
  its('cidr_block') { should eq '10.0.0.0/16' }
end

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
```

These instances were created in various security groups. An instance can belong to one or more security groups. A security group places a firewall around the instance ensuring that the only the desired inbound/outbound requests reach the instance. At the moment we can ensure the existence of this security group but cannot determine the inbound/ingress and outbound/egress rules. A later version of InSpec will deliver the feature.

```ruby
describe aws_ec2_instance(name: 'webserver') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('subnet_id') { should eq 'subnet-21c8f345' }
  its('security_group_ids') { should cmp ["sg-42bfbc35", "sg-e8b6b59f"] }
end

describe aws_ec2_instance(name: 'database') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('subnet_id') { should eq 'subnet-fcdce798' }
  its('security_group_ids') { should cmp 'sg-42bfbc35' }
end

describe aws_vpc('vpc-d875a1a3') do
  its('state') { should be 'available' }
  its('cidr_block') { should eq '10.0.0.0/16' }
end

describe aws_subnet('subnet-03132867') do
  it { should exist }
  its('vpc_id') { should eq 'vpc-d875a1a3' }
  its('cidr_block') { should eq '10.0.0.0/24' }
  its('availability_zone') { should eq 'us-east-1a' }
end

describe aws_security_group('sg-b5eee0c2') do
  it { should exist }
  # TODO: Add security_group ingress/egress rules (when developed)
end

describe aws_security_group('sg-36d3dd41') do
  it { should exist }
  # TODO: Add security_group ingress/egress rules (when developed)
end

describe aws_security_group('sg-8bd1dffc') do
  it { should exist }
  # TODO: Add security_group ingress/egress rules (when developed)
end
```

Now you have a profile for this instance of your infrastructure.

## Refactor to have dynamic values with attributes.

The profile you created has hard-coded values. To work around that you have two approaches: profile attributes and profiles files

### Profile Attributes

These values are important as they will assist you in writing your profile with the correct id values. Using the results of this command is more work but enables you to create a profile that will continue to work as these values change.

InSpec profiles provide support for attributes to be provided during the time of execution of the scan. When you execute a `inspec exec` you can optionally pass the flag `--attrs attributes.yml`. Attributes only support yaml files. The output from Terraform is not in that format.

Run the `output` subcommand again but this time converting the format to YAML.

```shell
$ echo "${$(terraform output)//=/:}"
ec2_instance_alpha : i-05121225e94646a2b
```

Save it to a file.

```shell
$ echo "${$(terraform output)//=/:}" > attributes.yml
```

Now define the attributes within the control file and replace the hard-coded value with the value defined in the attribute.

```ruby
webserver_id = attribute('ec2_instance.webserver', description: 'webserver id')

describe aws_ec2_instance(webserver_id) do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-6c65b317' }
  its('subnet_id') { should eq 'subnet-6d417b09' }
  its('security_group_ids') { should cmp ["sg-b5eee0c2", "sg-36d3dd41"] }
end
```

The remaining attributes defined in the `attributes.yml` would need to become attributes within this control file.

### Profile Files

[Reference](https://github.com/chris-rock/inspec-verify-provision/tree/master/terraform/)

For long standing applications/environments built with terraform you will likely want to permanently add the output values to the profile itself. This is best done by capturing the Terraform output and then adding that content as a profile files.

Recall that profile files are stored in the `files` sub-directory within a project. A profile file can be any particular format. Create the `files` sub-directory within the profile.

```shell
$ mkdir PROFILE/files
```

While we could export the content again from the Terraform output to YAML, this time use the JSON format output.

```shell
$ terraform output --json
{
  "ec2_instance.webserver": {
      "sensitive": false,
      "type": "string",
      "value": "i-004807f12125d2437"
  }
}
```

The output contains all the same information with some additional metadata to describe the structure and the sensitivity of that information. All of the data produced by the terraform file provided are strings, text, and not sensitive. Never store any sensitive information within a profile that you commit to a source repository. All users that have access to that repository may compromise the security of your infrastructure!

Run the `output` subcommand with the JSON flag and save the contents to the files directory.

```shell
$ terraform output --json > PROFILE/files/terraform.json
```

Load this data within the control file.

```ruby
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

webserver_id = params['ec2_instance.webserver']['value']

describe aws_ec2_instance(webserver_id) do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-6c65b317' }
  its('subnet_id') { should eq 'subnet-6d417b09' }
  its('security_group_ids') { should cmp ["sg-b5eee0c2", "sg-36d3dd41"] }
end
```

The content is loaded through the `inspec.profile.file` method. This content is a String that contains the JSON content. Ruby's JSON parser will convert the string content into Hash object. The structure of the content can then be accessed through the keys that are defined.
