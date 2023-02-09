variable "POSTGRES_HOST" {
  type        = string
  default     = "db"
}

variable "POSTGRES_DB" {
  type        = string
  default     = "postgres"
}

variable "POSTGRES_USER" {
  type        = string
  default     = "postgres"
}

variable "POSTGRES_PORT" {
  default     = 5432
}

variable "POSTGRES_PASSWORD" {
  type        = string
  default     = "postgres"
}