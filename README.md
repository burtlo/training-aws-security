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

  + aws_instance.alpha
      id:                           <computed>
      ami:                          "ami-d5d7ffae"
      associate_public_ip_address:  <computed>
      availability_zone:            <computed>
      ebs_block_device.#:           <computed>
      ephemeral_block_device.#:     <computed>
      instance_state:               <computed>
      instance_type:                "t1.micro"
      ipv6_address_count:           <computed>
      ipv6_addresses.#:             <computed>
      key_name:                     <computed>
      network_interface.#:          <computed>
      network_interface_id:         <computed>
      placement_group:              <computed>
      primary_network_interface_id: <computed>
      private_dns:                  <computed>
      private_ip:                   <computed>
      public_dns:                   <computed>
      public_ip:                    <computed>
      root_block_device.#:          <computed>
      security_groups.#:            <computed>
      source_dest_check:            "true"
      subnet_id:                    <computed>
      tenancy:                      <computed>
      volume_tags.%:                <computed>
      vpc_security_group_ids.#:     <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

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

  + aws_instance.alpha
      id:                           <computed>
      ami:                          "ami-d5d7ffae"
      associate_public_ip_address:  <computed>
      availability_zone:            <computed>
      ebs_block_device.#:           <computed>
      ephemeral_block_device.#:     <computed>
      instance_state:               <computed>
      instance_type:                "t1.micro"
      ipv6_address_count:           <computed>
      ipv6_addresses.#:             <computed>
      key_name:                     <computed>
      network_interface.#:          <computed>
      network_interface_id:         <computed>
      placement_group:              <computed>
      primary_network_interface_id: <computed>
      private_dns:                  <computed>
      private_ip:                   <computed>
      public_dns:                   <computed>
      public_ip:                    <computed>
      root_block_device.#:          <computed>
      security_groups.#:            <computed>
      source_dest_check:            "true"
      subnet_id:                    <computed>
      tenancy:                      <computed>
      volume_tags.%:                <computed>
      vpc_security_group_ids.#:     <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

This output is similar to the output you saw when you ran the `plan` subcommand with the addition of a prompt asking you to approve the application of the plan. Enter the value `yes` to create the plan.

```shell
  Enter a value: yes

aws_instance.alpha: Creating...
  ami:                          "" => "ami-d5d7ffae"
  associate_public_ip_address:  "" => "<computed>"
  availability_zone:            "" => "<computed>"
  ebs_block_device.#:           "" => "<computed>"
  ephemeral_block_device.#:     "" => "<computed>"
  instance_state:               "" => "<computed>"
  instance_type:                "" => "t1.micro"
  ipv6_address_count:           "" => "<computed>"
  ipv6_addresses.#:             "" => "<computed>"
  key_name:                     "" => "<computed>"
  network_interface.#:          "" => "<computed>"
  network_interface_id:         "" => "<computed>"
  placement_group:              "" => "<computed>"
  primary_network_interface_id: "" => "<computed>"
  private_dns:                  "" => "<computed>"
  private_ip:                   "" => "<computed>"
  public_dns:                   "" => "<computed>"
  public_ip:                    "" => "<computed>"
  root_block_device.#:          "" => "<computed>"
  security_groups.#:            "" => "<computed>"
  source_dest_check:            "" => "true"
  subnet_id:                    "" => "<computed>"
  tenancy:                      "" => "<computed>"
  volume_tags.%:                "" => "<computed>"
  vpc_security_group_ids.#:     "" => "<computed>"
aws_instance.alpha: Still creating... (10s elapsed)
aws_instance.alpha: Still creating... (20s elapsed)
aws_instance.alpha: Creation complete after 22s (ID: i-0859e3aeefc45cf6a)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

ec2_instance_alpha = i-0859e3aeefc45cf6a
```

The creation of the application is under way. The output reports each resource that created with updates for resources, like EC2 instances, that take longer to complete the creation.

The created plan will express a summary of results and then finally output any values that the plan explicitly was told to output.

Run the `plan` subcommand.

```shell
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_instance.alpha: Refreshing state... (ID: i-0859e3aeefc45cf6a)

------------------------------------------------------------------------

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.
```

Recall that when you ran the `plan` subcommand it displayed a list of resources that it would create for you. Now Terraform will evaluate the requirements of the plan against the current state of the application.

Run the `output` subcommand.

```shell
$ terraform output
ec2_instance_alpha = i-0859e3aeefc45cf6a
```

This displays the output values from the application that was created. Time to write a control that ensures that this instance is running.

Remove the `controls/example.rb`. Create a `controls/instances.rb` with the content:

```ruby

describe aws_ec2_instance('i-0859e3aeefc45cf6a') do
  it { should be_running }
  its(:image_id) { should eq 'ami-d5d7ffae' }
end
```

This control will find the instance with the specified id and then execute two tests to verify that the instance is running and that it is running the correct image id. This image id value is defined in the `setup.tf`.

Now it is time to perform a scan with this profile. Recall that when you execute a scan you specify a target. This target has traditionally been a protocol with the system and the required credentials. InSpec is able to also target cloud providers as a target using `aws://REGION`.

Execute a scan with this profile targeting the AWS platform in the us-east-1 region.

```shell
$ inspec exec PROFILE -t aws://us-east-1

Profile: InSpec Profile (training-aws-security)
Version: 0.1.0
Target:  aws://us-east-1

  ✔  aws-1: Checks the machine is running
     ✔  EC2 Instance i-0859e3aeefc45cf6a should be running
     ✔  EC2 Instance i-0859e3aeefc45cf6a image_id should eq "ami-d5d7ffae"


Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
Test Summary: 2 successful, 0 failures, 0 skipped
```

The results of the scan show that the instance ` i-0859e3aeefc45cf6a` is running and has defined with the the correct ID.

# TODO:

# Test that each machine is the right image size, using the right AMI, in the expected region, etc.
# Test that each machine is in the right security group and subnet (you can show them how to find a machine by ID but also by name, the latter of which is more practical)
# Test for subnet config
# Test for correct VPC config as a whole
# Test for proper network routing table (optional)
# An S3 bucket to store static assets uploaded by users for the correct permissions

# DOES NOT WORK YET - Test for security group configs - ingress and egress rules



## Refactor to have dynamic values with attributes.

The profile you created has hard-coded values. To work around that you have two approaches: profile attributes and profiles files

### Profile Attributes

These values are important as they will assist you in writing your profile with the correct id values. Using the results of this command is more work but enables you to create a profile that will continue to work as these values change.

InSpec profiles provide support for attributes to be provided during the time of execution of the scan. When you execute a `inspec exec` you can optionally pass the flag `--attrs attributes.yml`. Attributes only support yaml files. The output from Terraform is not in that format.

Run the `output` subcommand again but this time converting the format to YAML.

```shell
$ echo ${$(terraform output)/=/:}
ec2_instance_alpha : i-0859e3aeefc45cf6a
```

Save it to a file.

```shell
$ echo ${$(terraform output)/=/:} > attributes.yml
```

Now define the attributes within the control file and replace the hard-coded value with the value defined in the attribute.

```ruby

alpha_instance = attributes('ec2_instance_alpha', description: 'The first instance')

control 'aws-instance' do
  describe aws_ec2_instance(alpha_instance) do
    it { should be_running }
    its(:image_id) { should eq 'ami-d5d7ffae' }
  end
end
```

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
    "ec2_instance_alpha": {
        "sensitive": false,
        "type": "string",
        "value": "i-0859e3aeefc45cf6a"
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

# store vpc in variable
alpha_instance = params['ec2_instance_alpha']['value']

control 'aws-instance' do
  describe aws_ec2_instance(alpha_instance) do
    it { should be_running }
    its(:image_id) { should eq 'ami-d5d7ffae' }
  end
end
```

The content is loaded through the `inspec.profile.file` method. This content is a string that contains the JSON content. Ruby's JSON parser will convert the string content into Hash object. The structure of the content can then be accessed through the keys that are defined.
