variable "name" {
  type        = string
  description = "Nome da instancia"
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "dev"
}

variable "ebs_block_device" {
  description = "Lista de volumes ebs para ser criado e montado na instancia"
  type        = list(any)
  default     = []
}