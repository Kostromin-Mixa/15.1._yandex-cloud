terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.68.0"
    }
  }
}

provider "yandex" {
  token     = "AQAAAABbbCeCAATuwdgA0RU1k0v0okfVuCK0nKI"
  cloud_id  = "b1gqlrb7p6gvtjhuv1pe"
  folder_id = "b1g14831kdnla0i7bo67"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "network" {
  name = "netology"
}
resource "yandex_vpc_subnet" "public-subnet" {
  name           = "public"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  description    = "NAT instance"
  network_id     = yandex_vpc_network.network.id
}
 resource "yandex_vpc_subnet" "private-subnet" {
  name           = "private"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-a"
  description    = "Private instance"
  network_id     = yandex_vpc_network.network.id
}

resource "yandex_compute_instance" "default" {
  name        = "vm1"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
  
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public-subnet.id
    nat       = true
    ip_address = "192.168.10.254"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

}

resource "yandex_compute_instance" "mixa" {
  name        = "vm2"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
  
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private-subnet.id
  }

  metadata = {
     ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
 }

resource "yandex_vpc_route_table" "net-rt" {
  network_id = "${yandex_vpc_network.network.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.default.network_interface[0].ip_address
  }
}


