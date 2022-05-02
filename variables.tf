variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "ecrs" {
  description = "Map of ECRs to create."
  type        = any
  default     = {}

  # validation {
  #   condition = alltrue([
  #     for k, v in var.services : can(v["min_capacity"]) && can(v["min_capacity"])
  #   ])
  #   error_message = "'min_capacity' and 'max_capacity' should be set for a service."
  # }
}
