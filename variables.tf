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

variable "LOGIN_REDIRECT_URL" {
  type        = string
  default     = "http://localhost:3000/"
}

variable "GITHUB_CLIENT_ID" {
  default     = "GITHUB_CLIENT_ID"
}

variable "GITHUB_SECRET" {
  default     = "GITHUB_SECRET"
}

variable "NEXT_PUBLIC_API_URL" {
  type        = string
  default     = "http://localhost:8080/api/v1/"
}

variable "SERVICE_URL" {
  type        = string
  default     = "http://localhost:8080/api/v1/"
}


