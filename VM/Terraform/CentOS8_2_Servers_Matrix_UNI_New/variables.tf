variable "flavor" { default = "m1.large" }
variable "image" { default = "CentOS 8 20210305" }
variable "name1" { default = "CentOS 1" }
variable "name2" { default = "CentOS 2" }
variable "keypair" { default = "cloud" } # you may need to change this
variable "pool" { default = "cscloud_private_floating" }
variable "server1_script" { default = "./server1.sh" }
variable "server2_script" { default = "./server2.sh" }
variable "security_description" { default = "Terraform security group" }
variable "security_name" { default = "tf_security" }