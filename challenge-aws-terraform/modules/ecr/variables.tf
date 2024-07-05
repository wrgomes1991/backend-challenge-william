variable "name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of MUTABLE or IMMUTABLE"
  type        = string
  default     = "MUTABLE"
}
