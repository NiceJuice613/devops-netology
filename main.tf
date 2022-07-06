terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

backend "s3" {
  endpoint = "storage.yandexcloud.net"
  bucket = "bucketiv"
  region = "ru-central1"
  key = "home/ivani/Terraform/"
  access_key = "YCAJEs0KlHhn37Bp_Me7UCf0r"
  secret_key = "YCNWf9WOFAqvw2oWOimHvHmTvDivHXYwm0GYx2-G"

  skip_region_validation = true
  skip_credentials_validation = true

    }
  }

provider "yandex" {
  token     = "AQAAAAA7ZUQNAATuwWJIT69ao0T3k2jNvzp3dwE"
  cloud_id  = "b1g346r19jbf2u7rrrfl"
  folder_id = "b1g52qq5gi6nmlq7sbs4"
  #service_account_key_file = "ivanserv-key.json"
  zone      = "ru-central1-a"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-1804-lts-vgpu"
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

resource "yandex_compute_instance" "ivcent" {
  name        = "ivcent"
  zone        = "ru-central1-a"
  hostname    = "ivcent.netology.cloud"
  allow_stopping_for_update = true
  
  resources {
    cores         = 8
    memory        = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd807ed79a4kkqfvd1mb"
      name     = "root-ivcent"
      type     = "network-nvme"
      size     = "50"
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
