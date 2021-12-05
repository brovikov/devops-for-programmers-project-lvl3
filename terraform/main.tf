data "digitalocean_ssh_key" "mac-key" {
  name = "mac"
}

resource "digitalocean_droplet" "web-01" {
  image  = "docker-20-04"
  name   = "project3-web-01"
  region = "ams3"
  size   = "s-1vcpu-1gb"

  // Добавление приватного ключа на создаваемый сервер
  // Обращение к datasource выполняется через data.
  ssh_keys = [
    data.digitalocean_ssh_key.mac-key.id
  ]
}

resource "digitalocean_droplet" "web-02" {
  image  = "docker-20-04"
  name   = "project3-web-02"
  region = "ams3"
  size   = "s-1vcpu-1gb"

  // Добавление приватного ключа на создаваемый сервер
  ssh_keys = [
    data.digitalocean_ssh_key.mac-key.id
  ]
}

resource "digitalocean_certificate" "cert" {
  name    = "le-terraform-example"
  type    = "lets_encrypt"
  domains = ["project.hexlet-task.pp.ua"]
}

// Создание балансировщика нагрузки
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer
resource "digitalocean_loadbalancer" "lb" {
  name   = "lb"
  region = "ams3"

  forwarding_rule {
    // порт по которому балансировщик принимает запросы
    entry_port     = 80
    entry_protocol = "http"

    // порт по которому балансировщик передает запросы (на другие сервера)
    target_port     = 8080
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 8080
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert.name
  }

  healthcheck {
    port     = 8080
    protocol = "http"
    path     = "/"
  }


  droplet_ids = [
    digitalocean_droplet.web-01.id,
    digitalocean_droplet.web-02.id
  ]
}
// Создание домена
// https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain
resource "digitalocean_domain" "example" {
  name       = "project.hexlet-task.pp.ua"
  ip_address = digitalocean_loadbalancer.lb.ip
}

// Outputs похожи на возвращаемые значения. Они позволяют сгруппировать информацию или распечатать то, что нам необходимо
// https://www.terraform.io/docs/language/values/outputs.html
output "droplets_ips" {
  // Обращение к ресурсу. Каждый ресурс имеет атрибуты, ккоторым можно получить доступ
  value = [
    digitalocean_droplet.web-01.ipv4_address,
    digitalocean_droplet.web-02.ipv4_address
  ]
}

resource "datadog_monitor" "http_monitor" {
	name    = "http check"
	type    = "service check"
	query   = "\"http.can_connect\".over(\"instance:application_health_check_status\").by(\"host\",\"instance\",\"url\").last(2).count_by_status()"
	message = "http health check @alexey.brovikov@gmail.com"
	tags    = []

  monitor_thresholds {
    warning  = 1
    ok       = 1
    critical = 1
  }

  notify_no_data    = true
  no_data_timeframe = 2
  renotify_interval = 0
  new_group_delay   = 60

  notify_audit = false
  locked       = false

  timeout_h    = 60
  include_tags = true

  priority = 5
}
