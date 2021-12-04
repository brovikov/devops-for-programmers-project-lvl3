variable "pvt_key" {
  default = "~/.ssh/id_rsa"
}

variable "do_token" {
  description = "DO API token"
  type        = string
}

variable "datadog_api_key" {
  description = "DataDog API key"
  type        = string
}

variable "datadog_app_key" {
  description = "DataDog API key"
  type        = string
}
