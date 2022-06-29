terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "XXXXXX"
  cloud_id  = "b1g346r19jbf2u7rrrfl"
  folder_id = "b1g52qq5gi6nmlq7sbs4"
  zone      = "ru-central1-a"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts-gpu"
}

resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name           = "subnet"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
  zone           = "ru-central1-a"
}

resource "yandex_compute_instance" "ubuntIV" {
  name        = "ubuntIV"
  hostname    = "ubuntIV.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80d7fnvf399b1c207j"
      name     = "root-ubuntIV"
      type     = "network-hdd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
