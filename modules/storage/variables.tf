variable "bucket_count" {
  description = "Number of public buckets to create"
  type        = number
  default     = 3
  validation {
    condition     = var.bucket_count > 0 && var.bucket_count <= 10
    error_message = "Bucket count must be between 1 and 10."
  }
}

variable "bucket_prefix" {
  description = "Prefix for bucket names (will be appended with index and random suffix)"
  type        = string
  default     = "public-bucket"
}

variable "bucket_names" {
  description = "Custom bucket names (overrides bucket_prefix if provided)"
  type        = list(string)
  default     = []
}

variable "use_custom_names" {
  description = "Whether to use custom bucket names"
  type        = bool
  default     = false
}

variable "bucket_acl" {
  description = "ACL for the buckets"
  type        = string
  default     = "public-read"
  validation {
    condition     = contains(["private", "public-read", "public-read-write", "aws-exec-read"], var.bucket_acl)
    error_message = "ACL must be one of: private, public-read, public-read-write, aws-exec-read."
  }
}

variable "enable_versioning" {
  description = "Enable versioning for the buckets"
  type        = bool
  default     = false
}

variable "enable_website" {
  description = "Enable static website hosting"
  type        = bool
  default     = false
}

variable "website_index_document" {
  description = "Index document for website configuration"
  type        = string
  default     = "index.html"
}

variable "website_error_document" {
  description = "Error document for website configuration"
  type        = string
  default     = "error.html"
}

variable "tags" {
  description = "Additional tags for the buckets"
  type        = map(string)
  default     = {}
}
