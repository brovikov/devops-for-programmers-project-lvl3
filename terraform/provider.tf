terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "example" {
  name = "mac"
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
