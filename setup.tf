variable "aws_region" {
  description = "AWS region to launch servers."
  # This value is being hard-coded to this region. I believe it could be specified at run-time or at some other point. I haven't spent much time with the variables yet to know all the details.
  default     = "us-east-1"
}


variable "aws_amis" {
  default = {
    # This variable is used later for the lookup based on the region value. This is useful if you want to build things in different regions. This pattern was in the already existing examples.
    # Chef Essentials 7.0.0
    us-east-1 = "ami-d5d7ffae"
  }
}

# When the process of spining up the platform is done report this data out to the command line. This is essential if you want to know what id was generated for this instance after it was created.
output "ec2_instance_alpha" {
  value = "${aws_instance.alpha.id}"
}


# Create an aws_instance with the name 'alpha' using the AMI that is correct for the region and make it small one so that we aren't burning up all that delicious start up money.
resource "aws_instance" "alpha" {
  ami           = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "t1.micro"
  security_groups = ["${aws_security_group.ssh_web.id}"]
  subnet_id = "${aws_subnet.default.id}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# resource "aws_security_group" "web" {
#   name        = "learn_chef_web"
#   description = "Used in a terraform exercise"
#   vpc_id      = "${aws_vpc.default.id}"
#
#   # HTTP access from anywhere
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   # outbound internet access
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_security_group" "ssh_web" {
  name        = "learn_chef_ssh_web"
  description = "Used in a terraform exercise"
  vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Test for correct VPC config as a whole
# Test for subnet config
# Test for security group configs - ingress and egress rules
# Test for proper network routing table (optional)
# Test that each machine is in the right security group and subnet (you can show them how to find a machine by ID but also by name, the latter of which is more practical)
# Test that each machine is the right image size, using the right AMI, in the expected region, etc.
# An S3 bucket to store static assets uploaded by users for the correct permissions

# # Our default security group to access
# # the instances over SSH and HTTP
#
# resource "aws_elb" "web" {
#   name = "terraform-example-elb"
#
#   subnets         = ["${aws_subnet.default.id}"]
#   security_groups = ["${aws_security_group.elb.id}"]
#   instances       = ["${aws_instance.web.id}"]
#
#   listener {
#     instance_port     = 80
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }
# }

# resource "aws_instance" "web" {
#   # The connection block tells our provisioner how to
#   # communicate with the resource (instance)
#   connection {
#     # The default username for our AMI
#     user = "ubuntu"
#
#     # The connection will use the local SSH agent for authentication.
#   }
#
#   instance_type = "t2.micro"
#
#   # Lookup the correct AMI based on the region
#   # we specified
#   ami = "${lookup(var.aws_amis, var.aws_region)}"
#
#   # The name of our SSH keypair we created above.
#   key_name = "${aws_key_pair.auth.id}"
#
#   # Our Security group to allow HTTP and SSH access
#   vpc_security_group_ids = ["${aws_security_group.default.id}"]
#
#   # We're going to launch into the same subnet as our ELB. In a production
#   # environment it's more common to have a separate private subnet for
#   # backend instances.
#   subnet_id = "${aws_subnet.default.id}"
#
#   # We run a remote provisioner on the instance after creating it.
#   # In this case, we just install nginx and start it. By default,
#   # this should be on port 80
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get -y update",
#       "sudo apt-get -y install nginx",
#       "sudo service nginx start",
#     ]
#   }
# }
