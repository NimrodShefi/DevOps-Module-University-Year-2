
You must use the GIT BASH shell with Terraform

#####

When you generate a key for OpenStack on Lapis, please call it "cloud.key"

When you import that key into OpenStack please call it "cloud"

Please remember to download your OpenStack RC File and place it in your project directory

Source the *-openrc.sh file in the Git Bash shell and enter your OpenStack password

You can then run terraform commands to create your servers e.g.

terraform init
terraform plan
terraform apply

Remember to destroy your servers when you have finished with them

If you leave them running on a commercial cloud provider they will bill you

terraform destroy --force