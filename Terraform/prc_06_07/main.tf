# Locals block to determine the configuration based on 'selected_environment_key'
locals {
  # Check if the selected key exists in the production environment map
  is_prod_key = can(var.aws_prd_env[var.selected_environment_key])

  # Select the appropriate environment map (prod or stg)
  # This uses a conditional expression: (condition ? true_value : false_value)
  selected_env_map = local.is_prod_key ? var.aws_prd_env : var.aws_stg_env

  # Get the specific configuration object based on the selected key
  # This will be the object for "prod-aps-1", "stg-apse-2", etc.
  current_instance_config = local.selected_env_map[var.selected_environment_key]

  # Determine the environment tag based on whether it's a prod or stg key
  current_env_tag_key = local.is_prod_key ? "prd" : "stg"
}


# AWS Provider Configuration
provider "aws" {
  # The region for the provider will now be dynamically set from the selected configuration
  region = local.current_instance_config.region
  access_key = "xxxxxx"
  secret_key = "xxxx"
  # IMPORTANT: For access_key and secret_key, it's best practice NOT to hardcode them
  # or pass them directly as variables in production. Use AWS CLI configuration,
  # environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY), or IAM Roles.
  # If you must pass them via variables, ensure they are marked 'sensitive = true'
  # in variables.tf and provided via terraform.tfvars (which is .gitignore'd).
  # For demonstration, I'll comment them out here, assuming you'll use best practices.
  # access_key = var.your_aws_access_key_variable # Example if you define them
  # secret_key = var.your_aws_secret_key_variable # Example if you define them
}

# Data source for security group (assuming 'jankins' SG already exists in AWS)
data "aws_security_group" "jankins" {
  name = "jankins"
}

# Resource: AWS EC2 Instance
resource "aws_instance" "jan" {
  # Instance type is now taken automatically from the selected configuration
  instance_type = local.current_instance_config.instance_type

  # AMI is now taken automatically from the selected configuration
  ami           = local.current_instance_config.ami

  # Security group IDs (using the ID of the data source)
  vpc_security_group_ids = [data.aws_security_group.jankins.id]

  # Availability Zone: Assuming your AMI is valid for the region,
  # and if you need a specific AZ, it should be part of your 'aws_prd_env' / 'aws_stg_env' object schema.
  # For now, we'll just use the region as a placeholder or remove if not strictly needed.
  # If your object had an 'availability_zone' attribute, you'd use: local.current_instance_config.availability_zone
  # For simplicity, we'll use the region for now, or you can add 'availability_zone = string' to your object type.
  # availability_zone = "${local.current_instance_config.region}a" # Example: region + 'a'

  # Tags: Dynamically apply tags based on the selected environment
  tags = merge(
    var.stg_tags[local.current_env_tag_key], # Selects either 'prd' or 'stg' tags from stg_tags variable
    {
    #  Name        = "${local.current_instance_config.name}-server" # Example: "prod-aps-1-server"
      Name = "${var.selected_environment_key}-instance"
      Environment = local.current_env_tag_key # Explicitly set the environment tag
      ManagedBy   = "Terraform"
    }
  )
}

# Output the public IP of the created instance
output "instance_public_ip" {
  description = "The public IP address of the created EC2 instance."
  value       = aws_instance.jan.public_ip
}

# Output the instance type used
output "used_instance_type" {
  description = "The EC2 instance type that was provisioned."
  value       = aws_instance.jan.instance_type
}

# Output the AMI ID used
output "used_ami_id" {
  description = "The AMI ID that was provisioned."
  value       = aws_instance.jan.ami
}

# Output the region where the instance was deployed
output "deployed_region" {
  description = "The AWS region where the instance was deployed."
  value       = local.current_instance_config.region
}
