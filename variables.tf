variable "AWS_REGION" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS access key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "AWS_PROFILE" {
  description = "AWS profile"
  type        = string
  sensitive   = true
  default     = "default"
}

variable "env" {
  description = "Environment variable abbreviation"
  type        = string
  default     = "staging"

  validation {
    condition     = contains(["staging", "prod"], var.env)
    error_message = "Invalid argument \"env\", please choose one of: (\"staging\",\"prod\")."
  }
}

### VPC variables
variable "single_nat_gateway" {
  type        = bool
  default     = true
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks. Consider setting to false for HA in production env."
}


### EKS variables
variable "eks_default_instance_type" {
  type        = string
  default     = "t3a.large"
  description = "Default instance type for EKS cluster"
}
