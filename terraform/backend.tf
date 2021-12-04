# https://www.terraform.io/docs/language/settings/backends/configuration.html
terraform {
  backend "remote" {
    organization = "hexlet-project-3"

    workspaces {
      name = "alex"
    }
  }
}
