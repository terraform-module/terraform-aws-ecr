variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "ecrs" {
  description = "Map of ECRs to create."
  type        = any
  default     = {}
}
