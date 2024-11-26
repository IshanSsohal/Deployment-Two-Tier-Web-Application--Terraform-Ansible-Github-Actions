config {
  
  module = true
 
  force = false
  
  disabled_by_default = false
 
}

plugin "aws" {
  enabled = true
  version = "latest"  
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

# Enable specific rules
rule "terraform_deprecated_interpolation" {
  enabled = true  
}

rule "terraform_unused_declarations" {
  enabled = true  
}

rule "terraform_naming_convention" {
  enabled = true  
  variable {
    format = "snake_case"  # Require snake_case for variable names
  }
  locals {
    format = "snake_case"  # Require snake_case for locals
  }
  output {
    format = "snake_case"  # Require snake_case for output names
  }
}


rule "terraform_documented_variables" {
  enabled = true  
}

rule "terraform_documented_outputs" {
  enabled = true  
}

rule "terraform_typed_variables" {
  enabled = true  
}

rule "aws_instance_invalid_type" {
  enabled = false  
}
