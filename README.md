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

  + aws_instance.database
      id:                                    <computed>
      ami:                                   "ami-d5d7ffae"
      associate_public_ip_address:           <computed>
      availability_zone:                     "us-east-1a"
      ebs_block_device.#:                    <computed>
      ephemeral_block_device.#:              <computed>
      instance_state:                        <computed>
      instance_type:                         "t1.micro"
      ipv6_address_count:                    <computed>
      ipv6_addresses.#:                      <computed>
      key_name:                              <computed>
      network_interface.#:                   <computed>
      network_interface_id:                  <computed>
      placement_group:                       <computed>
      primary_network_interface_id:          <computed>
      private_dns:                           <computed>
      private_ip:                            <computed>
      public_dns:                            <computed>
      public_ip:                             <computed>
      root_block_device.#:                   <computed>
      security_groups.#:                     <computed>
      source_dest_check:                     "true"
      subnet_id:                             "${aws_subnet.private.id}"
      tags.%:                                "1"
      tags.Name:                             "datase"
      tenancy:                               <computed>
      volume_tags.%:                         <computed>
      vpc_security_group_ids.#:              <computed>

  + aws_instance.webserver
      id:                                    <computed>
      ami:                                   "ami-d5d7ffae"
      associate_public_ip_address:           <computed>
      availability_zone:                     "us-east-1a"
      ebs_block_device.#:                    <computed>
      ephemeral_block_device.#:              <computed>
      instance_state:                        <computed>
      instance_type:                         "t1.micro"
      ipv6_address_count:                    <computed>
      ipv6_addresses.#:                      <computed>
      key_name:                              <computed>
      network_interface.#:                   <computed>
      network_interface_id:                  <computed>
      placement_group:                       <computed>
      primary_network_interface_id:          <computed>
      private_dns:                           <computed>
      private_ip:                            <computed>
      public_dns:                            <computed>
      public_ip:                             <computed>
      root_block_device.#:                   <computed>
      security_groups.#:                     <computed>
      source_dest_check:                     "true"
      subnet_id:                             "${aws_subnet.public.id}"
      tags.%:                                "1"
      tags.Name:                             "webserver"
      tenancy:                               <computed>
      volume_tags.%:                         <computed>
      vpc_security_group_ids.#:              <computed>

  + aws_internet_gateway.default
      id:                                    <computed>
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_route.internet_access
      id:                                    <computed>
      destination_cidr_block:                "0.0.0.0/0"
      destination_prefix_list_id:            <computed>
      egress_only_gateway_id:                <computed>
      gateway_id:                            "${aws_internet_gateway.default.id}"
      instance_id:                           <computed>
      instance_owner_id:                     <computed>
      nat_gateway_id:                        <computed>
      network_interface_id:                  <computed>
      origin:                                <computed>
      route_table_id:                        "${aws_vpc.default.main_route_table_id}"
      state:                                 <computed>

  + aws_security_group.ssh
      id:                                    <computed>
      description:                           "Used in a terraform exercise"
      egress.#:                              "1"
      egress.482069346.cidr_blocks.#:        "1"
      egress.482069346.cidr_blocks.0:        "0.0.0.0/0"
      egress.482069346.description:          ""
      egress.482069346.from_port:            "0"
      egress.482069346.ipv6_cidr_blocks.#:   "0"
      egress.482069346.prefix_list_ids.#:    "0"
      egress.482069346.protocol:             "-1"
      egress.482069346.security_groups.#:    "0"
      egress.482069346.self:                 "false"
      egress.482069346.to_port:              "0"
      ingress.#:                             "1"
      ingress.2541437006.cidr_blocks.#:      "1"
      ingress.2541437006.cidr_blocks.0:      "0.0.0.0/0"
      ingress.2541437006.description:        ""
      ingress.2541437006.from_port:          "22"
      ingress.2541437006.ipv6_cidr_blocks.#: "0"
      ingress.2541437006.protocol:           "tcp"
      ingress.2541437006.security_groups.#:  "0"
      ingress.2541437006.self:               "false"
      ingress.2541437006.to_port:            "22"
      name:                                  "learn_chef_ssh"
      owner_id:                              <computed>
      revoke_rules_on_delete:                "false"
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_security_group.web
      id:                                    <computed>
      description:                           "Used in a terraform exercise"
      egress.#:                              "1"
      egress.482069346.cidr_blocks.#:        "1"
      egress.482069346.cidr_blocks.0:        "0.0.0.0/0"
      egress.482069346.description:          ""
      egress.482069346.from_port:            "0"
      egress.482069346.ipv6_cidr_blocks.#:   "0"
      egress.482069346.prefix_list_ids.#:    "0"
      egress.482069346.protocol:             "-1"
      egress.482069346.security_groups.#:    "0"
      egress.482069346.self:                 "false"
      egress.482069346.to_port:              "0"
      ingress.#:                             "1"
      ingress.2165049311.cidr_blocks.#:      "1"
      ingress.2165049311.cidr_blocks.0:      "10.0.0.0/16"
      ingress.2165049311.description:        ""
      ingress.2165049311.from_port:          "80"
      ingress.2165049311.ipv6_cidr_blocks.#: "0"
      ingress.2165049311.protocol:           "tcp"
      ingress.2165049311.security_groups.#:  "0"
      ingress.2165049311.self:               "false"
      ingress.2165049311.to_port:            "80"
      name:                                  "learn_chef_web"
      owner_id:                              <computed>
      revoke_rules_on_delete:                "false"
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_subnet.private
      id:                                    <computed>
      assign_ipv6_address_on_creation:       "false"
      availability_zone:                     "us-east-1a"
      cidr_block:                            "10.0.100.0/24"
      ipv6_cidr_block:                       <computed>
      ipv6_cidr_block_association_id:        <computed>
      map_public_ip_on_launch:               "false"
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_subnet.public
      id:                                    <computed>
      assign_ipv6_address_on_creation:       "false"
      availability_zone:                     "us-east-1a"
      cidr_block:                            "10.0.1.0/24"
      ipv6_cidr_block:                       <computed>
      ipv6_cidr_block_association_id:        <computed>
      map_public_ip_on_launch:               "true"
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_vpc.default
      id:                                    <computed>
      assign_generated_ipv6_cidr_block:      "false"
      cidr_block:                            "10.0.0.0/16"
      default_network_acl_id:                <computed>
      default_route_table_id:                <computed>
      default_security_group_id:             <computed>
      dhcp_options_id:                       <computed>
      enable_classiclink:                    <computed>
      enable_classiclink_dns_support:        <computed>
      enable_dns_hostnames:                  <computed>
      enable_dns_support:                    "true"
      instance_tenancy:                      <computed>
      ipv6_association_id:                   <computed>
      ipv6_cidr_block:                       <computed>
      main_route_table_id:                   <computed>


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

  + aws_instance.database
      id:                                    <computed>
      ami:                                   "ami-d5d7ffae"
      associate_public_ip_address:           <computed>
      availability_zone:                     "us-east-1a"
      ebs_block_device.#:                    <computed>
      ephemeral_block_device.#:              <computed>
      instance_state:                        <computed>
      instance_type:                         "t1.micro"
      ipv6_address_count:                    <computed>
      ipv6_addresses.#:                      <computed>
      key_name:                              <computed>
      network_interface.#:                   <computed>
      network_interface_id:                  <computed>
      placement_group:                       <computed>
      primary_network_interface_id:          <computed>
      private_dns:                           <computed>
      private_ip:                            <computed>
      public_dns:                            <computed>
      public_ip:                             <computed>
      root_block_device.#:                   <computed>
      security_groups.#:                     <computed>
      source_dest_check:                     "true"
      subnet_id:                             "${aws_subnet.private.id}"
      tags.%:                                "1"
      tags.Name:                             "datase"
      tenancy:                               <computed>
      volume_tags.%:                         <computed>
      vpc_security_group_ids.#:              <computed>

  + aws_instance.webserver
      id:                                    <computed>
      ami:                                   "ami-d5d7ffae"
      associate_public_ip_address:           <computed>
      availability_zone:                     "us-east-1a"
      ebs_block_device.#:                    <computed>
      ephemeral_block_device.#:              <computed>
      instance_state:                        <computed>
      instance_type:                         "t1.micro"
      ipv6_address_count:                    <computed>
      ipv6_addresses.#:                      <computed>
      key_name:                              <computed>
      network_interface.#:                   <computed>
      network_interface_id:                  <computed>
      placement_group:                       <computed>
      primary_network_interface_id:          <computed>
      private_dns:                           <computed>
      private_ip:                            <computed>
      public_dns:                            <computed>
      public_ip:                             <computed>
      root_block_device.#:                   <computed>
      security_groups.#:                     <computed>
      source_dest_check:                     "true"
      subnet_id:                             "${aws_subnet.public.id}"
      tags.%:                                "1"
      tags.Name:                             "webserver"
      tenancy:                               <computed>
      volume_tags.%:                         <computed>
      vpc_security_group_ids.#:              <computed>

  + aws_internet_gateway.default
      id:                                    <computed>
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_route.internet_access
      id:                                    <computed>
      destination_cidr_block:                "0.0.0.0/0"
      destination_prefix_list_id:            <computed>
      egress_only_gateway_id:                <computed>
      gateway_id:                            "${aws_internet_gateway.default.id}"
      instance_id:                           <computed>
      instance_owner_id:                     <computed>
      nat_gateway_id:                        <computed>
      network_interface_id:                  <computed>
      origin:                                <computed>
      route_table_id:                        "${aws_vpc.default.main_route_table_id}"
      state:                                 <computed>

  + aws_security_group.ssh
      id:                                    <computed>
      description:                           "Used in a terraform exercise"
      egress.#:                              "1"
      egress.482069346.cidr_blocks.#:        "1"
      egress.482069346.cidr_blocks.0:        "0.0.0.0/0"
      egress.482069346.description:          ""
      egress.482069346.from_port:            "0"
      egress.482069346.ipv6_cidr_blocks.#:   "0"
      egress.482069346.prefix_list_ids.#:    "0"
      egress.482069346.protocol:             "-1"
      egress.482069346.security_groups.#:    "0"
      egress.482069346.self:                 "false"
      egress.482069346.to_port:              "0"
      ingress.#:                             "1"
      ingress.2541437006.cidr_blocks.#:      "1"
      ingress.2541437006.cidr_blocks.0:      "0.0.0.0/0"
      ingress.2541437006.description:        ""
      ingress.2541437006.from_port:          "22"
      ingress.2541437006.ipv6_cidr_blocks.#: "0"
      ingress.2541437006.protocol:           "tcp"
      ingress.2541437006.security_groups.#:  "0"
      ingress.2541437006.self:               "false"
      ingress.2541437006.to_port:            "22"
      name:                                  "learn_chef_ssh"
      owner_id:                              <computed>
      revoke_rules_on_delete:                "false"
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_security_group.web
      id:                                    <computed>
      description:                           "Used in a terraform exercise"
      egress.#:                              "1"
      egress.482069346.cidr_blocks.#:        "1"
      egress.482069346.cidr_blocks.0:        "0.0.0.0/0"
      egress.482069346.description:          ""
      egress.482069346.from_port:            "0"
      egress.482069346.ipv6_cidr_blocks.#:   "0"
      egress.482069346.prefix_list_ids.#:    "0"
      egress.482069346.protocol:             "-1"
      egress.482069346.security_groups.#:    "0"
      egress.482069346.self:                 "false"
      egress.482069346.to_port:              "0"
      ingress.#:                             "1"
      ingress.2165049311.cidr_blocks.#:      "1"
      ingress.2165049311.cidr_blocks.0:      "10.0.0.0/16"
      ingress.2165049311.description:        ""
      ingress.2165049311.from_port:          "80"
      ingress.2165049311.ipv6_cidr_blocks.#: "0"
      ingress.2165049311.protocol:           "tcp"
      ingress.2165049311.security_groups.#:  "0"
      ingress.2165049311.self:               "false"
      ingress.2165049311.to_port:            "80"
      name:                                  "learn_chef_web"
      owner_id:                              <computed>
      revoke_rules_on_delete:                "false"
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_subnet.private
      id:                                    <computed>
      assign_ipv6_address_on_creation:       "false"
      availability_zone:                     "us-east-1a"
      cidr_block:                            "10.0.100.0/24"
      ipv6_cidr_block:                       <computed>
      ipv6_cidr_block_association_id:        <computed>
      map_public_ip_on_launch:               "false"
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_subnet.public
      id:                                    <computed>
      assign_ipv6_address_on_creation:       "false"
      availability_zone:                     "us-east-1a"
      cidr_block:                            "10.0.1.0/24"
      ipv6_cidr_block:                       <computed>
      ipv6_cidr_block_association_id:        <computed>
      map_public_ip_on_launch:               "true"
      vpc_id:                                "${aws_vpc.default.id}"

  + aws_vpc.default
      id:                                    <computed>
      assign_generated_ipv6_cidr_block:      "false"
      cidr_block:                            "10.0.0.0/16"
      default_network_acl_id:                <computed>
      default_route_table_id:                <computed>
      default_security_group_id:             <computed>
      dhcp_options_id:                       <computed>
      enable_classiclink:                    <computed>
      enable_classiclink_dns_support:        <computed>
      enable_dns_hostnames:                  <computed>
      enable_dns_support:                    "true"
      instance_tenancy:                      <computed>
      ipv6_association_id:                   <computed>
      ipv6_cidr_block:                       <computed>
      main_route_table_id:                   <computed>


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
    assign_generated_ipv6_cidr_block: "" => "false"
    cidr_block:                       "" => "10.0.0.0/16"
    default_network_acl_id:           "" => "<computed>"
    default_route_table_id:           "" => "<computed>"
    default_security_group_id:        "" => "<computed>"
    dhcp_options_id:                  "" => "<computed>"
    enable_classiclink:               "" => "<computed>"
    enable_classiclink_dns_support:   "" => "<computed>"
    enable_dns_hostnames:             "" => "<computed>"
    enable_dns_support:               "" => "true"
    instance_tenancy:                 "" => "<computed>"
    ipv6_association_id:              "" => "<computed>"
    ipv6_cidr_block:                  "" => "<computed>"
    main_route_table_id:              "" => "<computed>"
  aws_vpc.default: Creation complete after 2s (ID: vpc-4e904735)
  aws_internet_gateway.default: Creating...
    vpc_id: "" => "vpc-4e904735"
  aws_subnet.private: Creating...
    assign_ipv6_address_on_creation: "" => "false"
    availability_zone:               "" => "us-east-1a"
    cidr_block:                      "" => "10.0.100.0/24"
    ipv6_cidr_block:                 "" => "<computed>"
    ipv6_cidr_block_association_id:  "" => "<computed>"
    map_public_ip_on_launch:         "" => "false"
    vpc_id:                          "" => "vpc-4e904735"
  aws_subnet.public: Creating...
    assign_ipv6_address_on_creation: "" => "false"
    availability_zone:               "" => "us-east-1a"
    cidr_block:                      "" => "10.0.1.0/24"
    ipv6_cidr_block:                 "" => "<computed>"
    ipv6_cidr_block_association_id:  "" => "<computed>"
    map_public_ip_on_launch:         "" => "true"
    vpc_id:                          "" => "vpc-4e904735"
  aws_security_group.web: Creating...
    description:                           "" => "Used in a terraform exercise"
    egress.#:                              "" => "1"
    egress.482069346.cidr_blocks.#:        "" => "1"
    egress.482069346.cidr_blocks.0:        "" => "0.0.0.0/0"
    egress.482069346.description:          "" => ""
    egress.482069346.from_port:            "" => "0"
    egress.482069346.ipv6_cidr_blocks.#:   "" => "0"
    egress.482069346.prefix_list_ids.#:    "" => "0"
    egress.482069346.protocol:             "" => "-1"
    egress.482069346.security_groups.#:    "" => "0"
    egress.482069346.self:                 "" => "false"
    egress.482069346.to_port:              "" => "0"
    ingress.#:                             "" => "1"
    ingress.2165049311.cidr_blocks.#:      "" => "1"
    ingress.2165049311.cidr_blocks.0:      "" => "10.0.0.0/16"
    ingress.2165049311.description:        "" => ""
    ingress.2165049311.from_port:          "" => "80"
    ingress.2165049311.ipv6_cidr_blocks.#: "" => "0"
    ingress.2165049311.protocol:           "" => "tcp"
    ingress.2165049311.security_groups.#:  "" => "0"
    ingress.2165049311.self:               "" => "false"
    ingress.2165049311.to_port:            "" => "80"
    name:                                  "" => "learn_chef_web"
    owner_id:                              "" => "<computed>"
    revoke_rules_on_delete:                "" => "false"
    vpc_id:                                "" => "vpc-4e904735"
  aws_security_group.ssh: Creating...
    description:                           "" => "Used in a terraform exercise"
    egress.#:                              "" => "1"
    egress.482069346.cidr_blocks.#:        "" => "1"
    egress.482069346.cidr_blocks.0:        "" => "0.0.0.0/0"
    egress.482069346.description:          "" => ""
    egress.482069346.from_port:            "" => "0"
    egress.482069346.ipv6_cidr_blocks.#:   "" => "0"
    egress.482069346.prefix_list_ids.#:    "" => "0"
    egress.482069346.protocol:             "" => "-1"
    egress.482069346.security_groups.#:    "" => "0"
    egress.482069346.self:                 "" => "false"
    egress.482069346.to_port:              "" => "0"
    ingress.#:                             "" => "1"
    ingress.2541437006.cidr_blocks.#:      "" => "1"
    ingress.2541437006.cidr_blocks.0:      "" => "0.0.0.0/0"
    ingress.2541437006.description:        "" => ""
    ingress.2541437006.from_port:          "" => "22"
    ingress.2541437006.ipv6_cidr_blocks.#: "" => "0"
    ingress.2541437006.protocol:           "" => "tcp"
    ingress.2541437006.security_groups.#:  "" => "0"
    ingress.2541437006.self:               "" => "false"
    ingress.2541437006.to_port:            "" => "22"
    name:                                  "" => "learn_chef_ssh"
    owner_id:                              "" => "<computed>"
    revoke_rules_on_delete:                "" => "false"
    vpc_id:                                "" => "vpc-4e904735"
  aws_internet_gateway.default: Creation complete after 2s (ID: igw-ef07f497)
  aws_route.internet_access: Creating...
    destination_cidr_block:     "" => "0.0.0.0/0"
    destination_prefix_list_id: "" => "<computed>"
    egress_only_gateway_id:     "" => "<computed>"
    gateway_id:                 "" => "igw-ef07f497"
    instance_id:                "" => "<computed>"
    instance_owner_id:          "" => "<computed>"
    nat_gateway_id:             "" => "<computed>"
    network_interface_id:       "" => "<computed>"
    origin:                     "" => "<computed>"
    route_table_id:             "" => "rtb-039e607f"
    state:                      "" => "<computed>"
  aws_subnet.private: Creation complete after 2s (ID: subnet-ee172c8a)
  aws_route.internet_access: Creation complete after 0s (ID: r-rtb-039e607f1080289494)
  aws_subnet.public: Creation complete after 2s (ID: subnet-170e3573)
  aws_security_group.ssh: Creation complete after 3s (ID: sg-d19c9da6)
  aws_instance.database: Creating...
    ami:                          "" => "ami-d5d7ffae"
    associate_public_ip_address:  "" => "<computed>"
    availability_zone:            "" => "us-east-1a"
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
    security_groups.#:            "" => "1"
    security_groups.2586951444:   "" => "sg-d19c9da6"
    source_dest_check:            "" => "true"
    subnet_id:                    "" => "subnet-ee172c8a"
    tags.%:                       "" => "1"
    tags.Name:                    "" => "datase"
    tenancy:                      "" => "<computed>"
    volume_tags.%:                "" => "<computed>"
    vpc_security_group_ids.#:     "" => "<computed>"
  aws_security_group.web: Creation complete after 3s (ID: sg-9f9b9ae8)
  aws_instance.webserver: Creating...
    ami:                          "" => "ami-d5d7ffae"
    associate_public_ip_address:  "" => "<computed>"
    availability_zone:            "" => "us-east-1a"
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
    security_groups.#:            "" => "2"
    security_groups.169839970:    "" => "sg-9f9b9ae8"
    security_groups.2586951444:   "" => "sg-d19c9da6"
    source_dest_check:            "" => "true"
    subnet_id:                    "" => "subnet-170e3573"
    tags.%:                       "" => "1"
    tags.Name:                    "" => "webserver"
    tenancy:                      "" => "<computed>"
    volume_tags.%:                "" => "<computed>"
    vpc_security_group_ids.#:     "" => "<computed>"
  aws_instance.database: Still creating... (10s elapsed)
  aws_instance.webserver: Still creating... (10s elapsed)
  aws_instance.database: Creation complete after 18s (ID: i-05617ff5e510454a5)
  aws_instance.webserver: Still creating... (20s elapsed)
  aws_instance.webserver: Creation complete after 23s (ID: i-05121225e94646a2b)

  Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

  Outputs:

  ec2_instance.database = i-01053bc7abd6c9da3
  ec2_instance.database.Name = database
  ec2_instance.database.ami = ami-d5d7ffae
  ec2_instance.database.instance_type = t1.micro
  ec2_instance.webserver = i-05121225e94646a2b
  ec2_instance.webserver.ami = ami-d5d7ffae
  ec2_instance.webserver.instance_type = t1.micro
  ec2_instance.webserver.name = webserver
  ec2_instance.webserver.public_ip = 34.205.39.217
  route.internet_access.id = r-rtb-fe758b821080289494
  security_group.ssh.id = sg-42bfbc35
  security_group.web.id = sg-e8b6b59f
  subnet.private.id = subnet-fcdce798
  subnet.public.id = subnet-21c8f345
  vpc.id = vpc-2300d758
```

The terraform plan finishes deployment and reports the resources that it has created.

Run the `plan` subcommand.


```shell
THIS OUTPUT WAS SUPPOSE TO SHOW THAT THE CURRENT STATE WAS THE SAME SO NO ACTION
WOULD BE TAKEN IF APPLIED. I AM SEEING THAT IT WILL RECREATE PORTIONS OF THE PLAN.
```

Recall that when you ran the `plan` subcommand it displayed a list of resources that it would create for you. Now Terraform will evaluate the requirements of the plan against the current state of the application.

Run the `output` subcommand.

```shell
$ terraform output
ec2_instance.database = i-01053bc7abd6c9da3
ec2_instance.database.Name = database
ec2_instance.database.ami = ami-d5d7ffae
ec2_instance.database.instance_type = t1.micro
ec2_instance.webserver = i-05121225e94646a2b
ec2_instance.webserver.ami = ami-d5d7ffae
ec2_instance.webserver.instance_type = t1.micro
ec2_instance.webserver.name = webserver
ec2_instance.webserver.public_ip = 34.205.39.217
route.internet_access.id = r-rtb-fe758b821080289494
security_group.ssh.id = sg-42bfbc35
security_group.web.id = sg-e8b6b59f
subnet.private.id = subnet-fcdce798
subnet.public.id = subnet-21c8f345
vpc.id = vpc-2300d758
```

This displays the output values from the application that was created. Time to write a control that ensures that this webserver and the database are running:

Remove the `controls/example.rb`.

Create a `controls/instances.rb` with the content:

```ruby
describe aws_ec2_instance(name: 'webserver') do
  it { should be_running }
end

describe aws_ec2_instance('i-05617ff5e510454a5') do
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

  EC2 Instance i-05121225e94646a2b
     ✔  should be running
  EC2 Instance i-01053bc7abd6c9da3
     ✔  should be running

Test Summary: 2 successful, 0 failures, 0 skipped
```

The results of the scan show that the two instances are running.

Asserting that the instance is running is a great start but it does not ensure that it was built from the correct image and running on the correct size instance.

This instance in us-east-1 is using the AMI with the id `ami-d5d7ffae` and for the size `t1.micro`. Note these values are defined in the terraform plan and appeared in the terraform output.

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

# Database
describe aws_ec2_instance(name: 'database') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
end

describe aws_vpc(aws_ec2_instance(name: 'webserver').vpc_id) do
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

# Database
describe aws_ec2_instance(name: 'database') do
  it { should be_running }
  its('image_id') { should eq 'ami-d5d7ffae' }
  its('instance_type') { should eq 't1.micro' }
  its('vpc_id') { should eq 'vpc-2300d758' }
  its('subnet_id') { should eq 'subnet-fcdce798' }
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
```

This instance was created in a security group. An instance can belong to one or more security groups. A security group places a firewall around the instance ensuring that the only the desired inbound/outbound requests reach the instance. At the moment we can ensure the existence of this security group but cannot determine the inbound/ingress and outbound/egress rules. A later version of InSpec will deliver the feature.

```ruby
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
```

# TODO: Add an S3 Bucket with correct permissions
# TODO: Add security_group ingress/egress rules (when developed)


## Refactor to have dynamic values with attributes.

The profile you created has hard-coded values. To work around that you have two approaches: profile attributes and profiles files

### Profile Attributes

These values are important as they will assist you in writing your profile with the correct id values. Using the results of this command is more work but enables you to create a profile that will continue to work as these values change.

InSpec profiles provide support for attributes to be provided during the time of execution of the scan. When you execute a `inspec exec` you can optionally pass the flag `--attrs attributes.yml`. Attributes only support yaml files. The output from Terraform is not in that format.

Run the `output` subcommand again but this time converting the format to YAML.

```shell
$ echo ${$(terraform output)/=/:}
ec2_instance_alpha : i-05121225e94646a2b
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
    its('image_id') { should eq 'ami-d5d7ffae' }
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
        "value": "i-05121225e94646a2b"
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
