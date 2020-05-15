variable "tags" {
  default = {}
}

variable "tgws" {
  type        = map(any)
  description = "Map of TGWs to create"
  default     = {}
}
