variable "name" {
  description = "Name used across resources created"
  type        = string
  default     = "Test"
}

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "webapp"
}

variable "environment" {
  description = "Name of the environment"
  type        = string
  default     = "dev"
}

variable "password" {
  description = "Name of the environment"
  type        = string
  default     = "Admin@123"
}

variable "subnets" {
  type        = list(string)
  description = "Subnets to deploy in"
  default     = ["subnet-4f98ed7e"]
}
