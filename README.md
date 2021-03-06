## General command order
```bash
terraform init
terraform plan
terraform apply
terraform state list
terraform state show aws_s3_bucket.terraform_course
terraform plan -destroy
terraform plan -destroy -out=filenametostoreplan
terraform destroy
```

## Terraform installation and first example of usage
- install terraform from "https://www.terraform.io/downloads.html"
- create an environment variable
- create AWS user named "terraform", having programmatic access
- download the csv file of newly created IAM user and put it under .aws folder with a name "credentials"
- create github repo named terraform, and clone it to the local

## Terraform init
- Terraform requires a project to first be initialized by finding any related .tf files. This is done by running the init command.
```bash
terraform init
```
- create "first_code.tf" under local repo, and write your first IaC which will create an S3 bucket!
```bash
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_course" {
  bucket = "tf-course-rafe-stefano"
  acl = "private"
}
```
- Apply your code, this command search for .tf file extention, look at the cloud provider, go through the plugins
```bash
terraform apply -target=resource  # -target=resource flag points to a specific tf file
```
```t
An execution plan has been generated and is shown below.      
Resource actions are indicated with the following symbols:    
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.terraform_course will be created
  + resource "aws_s3_bucket" "terraform_course" {
      + acceleration_status         = (known after apply)     
      + acl                         = "private"
      + arn                         = (known after apply)     
      + bucket                      = "tf-course-rafe-stefano"
      + bucket_domain_name          = (known after apply)     
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + versioning {
          + enabled    = (known after apply)
          + mfa_delete = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_s3_bucket.terraform_course: Creating...
aws_s3_bucket.terraform_course: Still creating... [10s elapsed]
aws_s3_bucket.terraform_course: Creation complete after 12s [id=tf-course-rafe-stefano]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
- The CLI will show the status and info about infrastructure, and ask for confirmation, if agreed write "yes"
- Terraform operations can be summarized:
    - refresh
    - plan
    - apply
    - destroy

## Terraform plan
- We can create an execution plan. The apply command is used in Terraform to reach a desired configuration for deployment. This means Terraform performs the known actions to take.

- To see available options:
```bash
terraform plan --help
```
- To see current status of our plan:
```bash
terraform plan
```
```t
aws_s3_bucket.terraform_course: Refreshing state... [id=tf-course-rafe-stefano]

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.
```
- To see the destroy plan:
```bash
terraform plan -destroy
```
```t
An execution plan has been generated and is shown below.  
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.terraform_course will be destroyed      
  - resource "aws_s3_bucket" "terraform_course" {
      - acl                         = "private" -> null
      - arn                         = "arn:aws:s3:::tf-course-rafe-stefano" -> null
      - bucket                      = "tf-course-rafe-stefano" -> null
      - bucket_domain_name          = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - bucket_regional_domain_name = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - force_destroy               = false -> null
      - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
      - id                          = "tf-course-rafe-stefano" -> null
      - region                      = "us-east-1" -> null
      - request_payer               = "BucketOwner" -> null

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```
- It shows the destroy plan, and notes "You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run." So, lets save the plan:
```bash
terraform plan -destroy -out=example
```
```t
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.terraform_course will be destroyed
  - resource "aws_s3_bucket" "terraform_course" {
      - acl                         = "private" -> null
      - arn                         = "arn:aws:s3:::tf-course-rafe-stefano" ->
      - bucket                      = "tf-course-rafe-stefano" -> null
      - bucket_domain_name          = "tf-course-rafe-stefano.s3.amazonaws.com
      - bucket_regional_domain_name = "tf-course-rafe-stefano.s3.amazonaws.com
      - force_destroy               = false -> null
      - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
      - id                          = "tf-course-rafe-stefano" -> null
      - region                      = "us-east-1" -> null
      - request_payer               = "BucketOwner" -> null

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

------------------------------------------------------------------------

This plan was saved to: example

To perform exactly these actions, run the following command to apply:
    terraform apply "example"
```
- To see the saved plan:
```bash
terraform show example
```
```t
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.terraform_course will be destroyed
  - resource "aws_s3_bucket" "terraform_course" {
      - acl                         = "private" -> null
      - arn                         = "arn:aws:s3:::tf-course-rafe-stefano" -> null
      - bucket                      = "tf-course-rafe-stefano" -> null
      - bucket_domain_name          = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - bucket_regional_domain_name = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - force_destroy               = false -> null
      - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
      - id                          = "tf-course-rafe-stefano" -> null
      - region                      = "us-east-1" -> null
      - request_payer               = "BucketOwner" -> null

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.
```
## Terraform State

- When an implementation of an infrastructure is planned or executed, Terraform uses a state file to determine that the current status is correct.

- Terraform state shows our intention, it may not be fitted with actual infrastructure.
- The last terraform state can be inspected from terraform.tfstate file. This is a JSON file. For example:
```t
{
  "version": 4,
  "terraform_version": "0.14.5",
  "serial": 1,
  "lineage": "5bec9aa0-64e0-5d77-a39e-95437076f3e9",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_s3_bucket",
      "name": "terraform_course",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "acceleration_status": "",
            "acl": "private",
            "arn": "arn:aws:s3:::tf-course-rafe-stefano",
            "bucket": "tf-course-rafe-stefano",
            "bucket_domain_name": "tf-course-rafe-stefano.s3.amazonaws.com",
            "bucket_prefix": null,
            "bucket_regional_domain_name": "tf-course-rafe-stefano.s3.amazonaws.com",
            "cors_rule": [],
            "force_destroy": false,
            "grant": [],
            "hosted_zone_id": "Z3AQBSTGFYJSTF",
            "id": "tf-course-rafe-stefano",
            "lifecycle_rule": [],
            "logging": [],
            "object_lock_configuration": [],
            "policy": null,
            "region": "us-east-1",
            "replication_configuration": [],
            "request_payer": "BucketOwner",
            "server_side_encryption_configuration": [],
            "tags": null,
            "versioning": [
              {
                "enabled": false,
                "mfa_delete": false
              }
            ],
            "website": [],
            "website_domain": null,
            "website_endpoint": null
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    }
  ]
}
```
- This is a local storage. There is also a remote storage for collaboration.
- There are some options with "terraform state" command. 
```bash
terraform state list
```
```t
aws_s3_bucket.terraform_course
```
- list option lists current infrastructure provisioned.
- to see any of listed service:
```bash
terraform state show aws_s3_bucket.terraform_course
```
```t
# aws_s3_bucket.terraform_course:
resource "aws_s3_bucket" "terraform_course" {
    acl                         = "private"
    arn                         = "arn:aws:s3:::tf-course-rafe-stefano"
    bucket                      = "tf-course-rafe-stefano"
    bucket_domain_name          = "tf-course-rafe-stefano.s3.amazonaws.com"
    bucket_regional_domain_name = "tf-course-rafe-stefano.s3.amazonaws.com"
    force_destroy               = false
    hosted_zone_id              = "Z3AQBSTGFYJSTF"
    id                          = "tf-course-rafe-stefano"
    region                      = "us-east-1"
    request_payer               = "BucketOwner"

    versioning {
        enabled    = false
        mfa_delete = false
    }
}
```
```bash
terraform show
```
```t
# aws_s3_bucket.terraform_course:
resource "aws_s3_bucket" "terraform_course" {
    acl                         = "private"
    arn                         = "arn:aws:s3:::tf-course-rafe-stefano"
    bucket                      = "tf-course-rafe-stefano"
    bucket_domain_name          = "tf-course-rafe-stefano.s3.amazonaws.com"
    bucket_regional_domain_name = "tf-course-rafe-stefano.s3.amazonaws.com"
    force_destroy               = false
    hosted_zone_id              = "Z3AQBSTGFYJSTF"
    id                          = "tf-course-rafe-stefano"
    region                      = "us-east-1"
    request_payer               = "BucketOwner"

    versioning {
        enabled    = false
        mfa_delete = false
    }
}
```
- A graph is a visual representation of a Terraform infrastructure project. To create a graph, the graph command can be used. The code output can then be used to build a visual graph.

- After the graph command is used, the graph code can be pasted to create a graph visual with a graph generator. To see graph version in dot format:
```bash
terraform graph
```
```t
digraph {
        compound = "true"
        newrank = "true"
        subgraph "root" {
                "[root] aws_s3_bucket.terraform_course (expand)" [label = "aws_s3_bucket.terraform_course", shape = "box"]
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" [label = "provider[\"registry.terraform.io/hashicorp/aws\"]", shape = "diamond"]
                "[root] aws_s3_bucket.terraform_course (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                "[root] meta.count-boundary (EachMode fixup)" -> "[root] aws_s3_bucket.terraform_course (expand)"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_s3_bucket.terraform_course (expand)"
                "[root] root" -> "[root] meta.count-boundary (EachMode fixup)"
                "[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
        }
}
```
- To visualize this graph, visit "http://www.jdolivet.byethost13.com/Logiciels/WebGraphviz/?i=1"

## Terraform Plan

- First make a plan, for example, a destroy plan:
```bash
terraform plan -destroy -out=destroyplan
```
```t
An execution plan has been generated and is shown below.       
Resource actions are indicated with the following symbols:     
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.terraform_course will be destroyed
  - resource "aws_s3_bucket" "terraform_course" {
      - acl                         = "private" -> null        
      - arn                         = "arn:aws:s3:::tf-course-rafe-stefano" -> null    
      - bucket                      = "tf-course-rafe-stefano" -> null
      - bucket_domain_name          = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - bucket_regional_domain_name = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - force_destroy               = false -> null
      - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
      - id                          = "tf-course-rafe-stefano" -> null
      - region                      = "us-east-1" -> null
      - request_payer               = "BucketOwner" -> null

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

------------------------------------------------------------------------

This plan was saved to: destroyplan

To perform exactly these actions, run the following command to apply:
    terraform apply "destroyplan"
```
- Now lets apply the plan:
```bash
terraform apply destroyplan
```
```t
aws_s3_bucket.terraform_course: Destroying... [id=tf-course-rafe-stefano]
aws_s3_bucket.terraform_course: Destruction complete after 1s

Apply complete! Resources: 0 added, 0 changed, 1 destroyed.
```
- Can be be executed without approval:
```bash
terraform apply -auto-approve
```
### Quiz:
- Which statement describes how Terraform works at a high level?
It compares code to existing infrastructure and makes appropriate changes. *
It defines an infrastructure as code by configuring device settings.
It applies infrastructure described in code to any defined systems.
It applies code to an existing infrastructure by making changes.
- How is a Terraform graph created?
by using the 'graph' command and then a graph generator *
by using the 'graph' command followed by the 'apply' command
by using a graph drawing utility plug-in with Terraform
by using the built-in 'graph' command and defining the graph size
- Which step is required before executing the code of a Terraform project for the first time?
implementation
installation
integration
initialization *
- Which Terraform command is used to reach a desired configuration?
apply' *
state'
init'
plan'
## Resources
- Resources are building blocks of terraform code. They define what of your infrastructure. Different settings for every provider.
```bash
# provider definition, isn't resource, just definition of the resource
provider "aws" {        
  profile = "default"
  region = "us-east-1"
}
# resource, type, name
resource "aws_s3_bucket" "terraform_course" {
  # details of the resource, as arguments, bucket name must be unique   
  bucket = "tf-course-rafe-stefano"    
  acl = "private"
}
```
### Basic Resource Types
- s3 with static website
```bash
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_s3_bucket" "s3_bucket_static_web" {
  bucket = "terraform.farukgunal.net"
  acl = "public-read"
  policy = "${file("policy.json")}"  # policy from external file
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
```
- VPC
```bash
provider "aws" {
  profile = "default"
  region = "us-east-1"
}
# Just adopts existing vpc, not creating new resource
resource "aws_default_vpc" "default" {
  tags = {
    "Name" = "Default VPC"
  }
}
```
- Security Group
```bash
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_security_group" "allow_tls" {
  ingress = [ {
    cidr_blocks = [ "1.2.3.4/32" ]
    from_port = 443
    protocol = "tcp"
    to_port = 443
  } ]
  # egress for outbound traffic, any protocol from any port
  egress = [ {       
    from_port = 0
    protocol = "-1"
    to_port = 0
  } ]
}
```
- EC2 instance
```bash
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
}
```
- Elastic IP
```bash
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_eip" "web" {
  instance = "${aws_instance.web.id}"
  vpc = true
}
```

## Terraform Style
- Indentation 2 spaces
- Single meta-arguments first
- Block meta-arguments last
- Line up = signs
- Group single arguments
- Use blank lines for readability

## Some excercise operations

- Modify prod.tf file, add default VPC block
```bash
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_s3_bucket" "prod_tf_course" {
  bucket = "tf-course-rafe-stefano"
  acl = "private"
}

resource "aws_default_vpc" "default" {
  tags = {
    "Name" = "Default VPC"
  }
}
```
- We have a tf file, ready to create a plan
```bash
terraform plan
```
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
```bash
  + create

Terraform will perform the following actions:

  # aws_default_vpc.default will be created
  + resource "aws_default_vpc" "default" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = (known after apply)
      + cidr_block                       = (known after apply)
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = (known after apply)
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = (known after apply)
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "Default VPC"
        }
    }

  # aws_s3_bucket.prod_tf_course will be created
  + resource "aws_s3_bucket" "prod_tf_course" {
      + acceleration_status         = (known after apply)
      + acl                         = "private"
      + arn                         = (known after apply)
      + bucket                      = "tf-course-rafe-stefano"
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + versioning {
          + enabled    = (known after apply)
          + mfa_delete = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```
## Naming convention
- Name using most specific specialty first and most general specialty last. networking-prod-us-west-aws

- If you want to look at the graph related to some special resources:
```bash
terraform graph | grep -v -e 'meta' -e 'close' -e 's3' -e 'vpc'
```
- After creating elb, may want to look at the dns of our elb:
```bash
terraform state show aws_elb.prod_web
```
### Adding ASG
- The terraform.io is a little confusing. Here is the sample with the latest version of launch template:
```json
resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-1a2b3c"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
}
```
- Comment out ec2, eip, eip association, and instance line of elb. Because we have a launch template now.
- vpc_zone_identifier (Optional) A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with availability_zones. This is subnet actually.
```json
vpc_zone_identifier = [ aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id ]
```
- add tag, this has a different syntax:
tag {
    key   = "Terraform"
    value = "true"
    propagate_at_launch = true
  }
- Need a asg attachment resource to connect elb to asg! Go to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment and copy first one.
```json
# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  elb                    = aws_elb.bar.id
}
```
- What is the significance of the "ami" information when selecting and deploying a server instance?
the instance power
the server type
the image used *
the cost incurred
- An AWS security group can be viewed as _____.
a firewall instance that protects the defined region within AWS
a resource group that can be assigned permissions
a firewall for instances that can be assigned to resources *
a resource that uses a firewall to protect any related instances
- The proper indentation in a Terraform file is how many spaces?
two tabbed spaces
a tabbed space
two spaces *
five spaces
- With Terraform, how do resources relate to infrastructure building blocks?
They are the "why."
They are the "where."
They are the "what." *
They are the "how."
- What is accomplished when using Terraform to create an auto-scaling group?
It creates and destroys EC2 instances based on things like load or on a schedule. *
It bundles S3 instances for scaling purposes.
It bundles VPC instances for scaling purposes.
It bundles EIP instances for scaling purposes.
- Which concepts are important to consider when scaling resources in Terraform code?
availability
variables
modules
dependencies * Dependencies are important to consider when scaling out systems through code. The code structure and how the dependencies are deployed will impact whether scaling will be an easy task or possibly even at all.
## Variables
- Good to organize the code.
```json
variable "webserver_ami" {
  type = string
  default = ami-045805cfa04cb5a27
}

resource "aws_instance" "web" {
  ami = var.webserver_ami
}
```
- Variables can be changed with apply command:
```bash
terraform apply -var="webserver_ami=ami-12345"
```
## Data Sources
- Similar to variable but data sources allow data to be fetched or computed for use elsewhere in Terraform configuration. Use of data sources allows a Terraform configuration to make use of information defined outside of Terraform, or defined by another separate Terraform configuration. Each provider may offer data sources alongside its set of resource types.
```json
data "aws_ami" "webserver_ami" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "webserver"
    Tested = "true"
    Deploy = "true"
  }

  resource "aws_instance" "web" {
  ami = data.aws_ami.webserver_ami.id
}
}
```
- Filter the latest ubuntu ami is possible:
```json
# Find the latest available AMI that is tagged with Component = web
data "aws_ami" "web" {
  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Component"
    values = ["web"]
  }

  most_recent = true
}
```
- Make a terraform.tfvars file and put some often used vars in it:
```json
whitelist               = ["0.0.0.0/0"]
web_image_id            = "ami-045805cfa04cb5a27"
web_instance_type       = "t2.micro"
web_desired_capacity    = 1
web_max_size            = 1
web_min_size            = 1
```
- After that you can use these vars in your code. First put them at the begining of your file; add variable before and type after:
```json
variable "whitelist" {type = list(string)}
variable "web_image_id" {type = string}
variable "web_instance_type" {type = string}
variable "web_desired_capacity" {type = number}
variable "web_max_size" {type = number}
variable "web_min_size" {type = number}
```
- To use inside your code use:
```json
var.whitelist
var.web_image_id
var.web_instance_type
var.web_desired_capacity
var.web_max_size
var.web_min_size
```
- After these changes the values for these variables will be asked to us while making plan!
## Modules
- A module is a container for multiple resources that are used together. The .tf files in your working directory when you run terraform plan or terraform apply together form the root module. That module may call other modules and connect them together by passing output values from one to input values of another.
- Most commonly, modules use:
  - Input variables to accept values from the calling module.
  - Output values to return results to the calling module, which it can then use to populate arguments elsewhere.
  - Resources to define one or more infrastructure objects that the module will manage.
- To create a module first make a directory called modules
- Inside this directory create another directory for your module, example is web_app
- Copy main tf file under this tree and call it main.tf, variables.tf, and outputs.tf as convention says:
```bash
cp prod.tf modules/web_app/main.tf
```
- Edit variables first:
```json
variable "web_image_id" {type = string}
variable "web_instance_type" {type = string}
variable "web_desired_capacity" {type = number}
variable "web_max_size" {type = number}
variable "web_min_size" {type = number}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}
```
- Edit main:
```json
resource "aws_elb" "this" {
  name            = "${web-app}-web"
  subnets         = var.subnets
  security_groups = var.security_groups

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  tags = {
    "Terraform" = "true"
    "Name"      = "Terraform"
  }
}

resource "aws_launch_template" "this" {
  name_prefix   = "${web-app}"
  image_id = var.web_image_id
  instance_type = var.web_instance_type

  tags = {
    "Terraform" = "true"
    "Name"      = "Terraform"
  }
}

resource "aws_autoscaling_group" "this" {
  vpc_zone_identifier = var.subnets
  desired_capacity    = var.web_desired_capacity
  max_size            = var.web_max_size
  min_size            = var.web_min_size

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  elb                    = aws_elb.this.id
}
```
- Edit outputs:
```json
output "dns_name" {
  value = aws_elb.this.dns_name
}
```
- Edit prod.tf:
```json
variable "whitelist" {type = list(string)}
variable "web_image_id" {type = string}
variable "web_instance_type" {type = string}
variable "web_desired_capacity" {type = number}
variable "web_max_size" {type = number}
variable "web_min_size" {type = number}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "prod_tf_course" {
  bucket = "tf-course-rafe-stefano"
  acl    = "private"
}

resource "aws_default_vpc" "default" {
  tags = {
    "Terraform" = "true"
    "Name"      = "Terraform"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1a"

  tags = {
    "Terraform" = "true"
    "Name"      = "Terraform"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "us-east-1b"

  tags = {
    "Terraform" = "true"
    "Name"      = "Terraform"
  }
}

resource "aws_security_group" "prod_web" {
  name        = "prod_web"
  description = "Allow http/s inbound traffic"

  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      # cidr_blocks = ["0.0.0.0/0"]
      cidr_blocks = var.whitelist
  }

  ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      # cidr_blocks = ["0.0.0.0/0"]
      cidr_blocks = var.whitelist
  }

  egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      # cidr_blocks     = ["0.0.0.0/0"]
      cidr_blocks = var.whitelist
  }

  tags = {
    "Terraform" = "true"
    "Name"      = "Terraform"
  }
}

module "web_app" {
  source = "./modules/web_app"
}

  web_image_id         = var.web_image_id
  web_instance_type    = var.web_instance_type
  web_desired_capacity = var.web_desired_capacity
  web_max_size         = var.web_max_size
  web_min_size         = var.web_min_size
  subnets              = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  security_groups      = [aws_security_group.prod_web.id]

  web_app              = "prod"
```
- At the end of prod.tf if we need the list of variables, you can do that:
```bash
cat modules/web_app/variables.tf >> prod.tf
```
- Dont forget to add web_app name to the variables.tf
```json
variable "web_app" {
  type = string
}
```
- After configure module, need to init terraform.
