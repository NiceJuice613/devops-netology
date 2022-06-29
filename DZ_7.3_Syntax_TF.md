
# Домашнее задание к занятию "7.2.  Облачные провайдеры и синтаксис Terraform"

#### Задача 1 (Вариант с Yandex.Cloud). Регистрация в ЯО и знакомство с основами 

1. Подробная инструкция на русском языке содержится [здесь](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart).

2. Обратите внимание на период бесплатного использования после регистрации аккаунта.

3. Используйте раздел "Подготовьте облако к работе" для регистрации аккаунта. Далее раздел "Настройте провайдер" для подготовки базового терраформ конфига.

4. Воспользуйтесь [инструкцией](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs) на сайте терраформа, что бы не указывать авторизационный токен в коде, а терраформ провайдер брал его из переменных окружений

   ![Screenshot_1](C:\Users\KING\Desktop\Screenshot_1.jpg)

#### Задача 2. Создание yandex_compute_instance через Терраформ

1. В каталоге `terraform` вашего основного репозитория, который был создан в начале курсе, создайте файл `main.tf` и `versions.tf`.

2. Зарегистрируйте провайдер
   1. Для [yandex.cloud](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs). Подробную инструкцию можно найти [здесь](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart).

3. Внимание! В гит репозиторий нельзя пушить ваши личные ключи доступа к аккаунту. Поэтому в предыдущем задании мы указывали их в виде переменных окружения.

4. В файле main.tf создайте ресурс
   1.  [yandex_compute_image](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_image).

5. Если вы выполнили первый пункт, то добейтесь того, что бы команда `terraform plan` выполнялась без ошибок.

```
root@ivaniVirtual:/home/ivani/Terraform# terraform validate
   Success! The configuration is valid.

   root@ivaniVirtual:/home/ivani/Terraform# terraform plan
   data.yandex_compute_image.ubuntu: Reading...
   data.yandex_compute_image.ubuntu: Read complete after 2s [id=fd8oc4qnq5kg274e0vbn]

   Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:

   + create

   Terraform will perform the following actions:
```

     # yandex_compute_instance.ubuntIV will be created
     + resource "yandex_compute_instance" "ubuntIV" {
         + allow_stopping_for_update = true
         + created_at                = (known after apply)
         + folder_id                 = (known after apply)
         + fqdn                      = (known after apply)
         + hostname                  = "ubuntIV.netology.cloud"
         + id                        = (known after apply)
         + metadata                  = {
             + "ssh-keys" = <<-EOT
                   ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6dcPy0DLRTouyyayXFgS7rPggW5f8gbfqCIWYR8eiraVJaIvrQMWY9lQRK3b9ETcTL58FsaAGeQr2FTqSRmk1AxZo2P2J7NCT7Vf+V9XiN5VyGr/zzOmWjJrruBQF8E1PAU7yv0gD+jUwp2/JMILNT0NkywkdxA3CkIqgTA1jtYbpj1E01Cej76HdG/OjTGP6PG5P80YMFjzsOndm60UIDs4C7sfWvUJJ341bvGSkuswOPGngt+LaDwuEVmPPAvON3wse0m+tQIfk5xQgJmuKbxf4Gju1J/+qlKhb8WITwvig2qFCeywVy10SYaoU6c8cHzbJPFECdagUYKkI65/CcYS1j7nAH3LxqDYWpE7CoiWoXUOvR/Y8IyXXgXcTlOdw0TAAM6xfv6QHDr/fSsqfcB5a340fRYCslZ2p5fkS88VdbHBNVdWrP8ZTYfMY1an/0XV+IDaFUILyW/qyFswa20xlHIni0vAWVROkD5XllQTYviIGIoHXtOrCMzAsBIs= root@ivaniVirtual
               EOT
             }
         + name                      = "ubuntIV"
         + network_acceleration_type = "standard"
         + platform_id               = "standard-v1"
         + service_account_id        = (known after apply)
         + status                    = (known after apply)
         + zone                      = (known after apply)
    
         + boot_disk {
             + auto_delete = true
             + device_name = (known after apply)
             + disk_id     = (known after apply)
             + mode        = (known after apply)
    
             + initialize_params {
                 + block_size  = (known after apply)
                 + description = (known after apply)
                 + image_id    = "fd80d7fnvf399b1c207j"
                 + name        = "root-ubuntIV"
                 + size        = 20
                 + snapshot_id = (known after apply)
                 + type        = "network-hdd"
               }
               }
    
         + network_interface {
             + index              = (known after apply)
             + ip_address         = (known after apply)
             + ipv4               = true
             + ipv6               = (known after apply)
             + ipv6_address       = (known after apply)
             + mac_address        = (known after apply)
             + nat                = true
             + nat_ip_address     = (known after apply)
             + nat_ip_version     = (known after apply)
             + security_group_ids = (known after apply)
             + subnet_id          = (known after apply)
           }
    
         + placement_policy {
             + host_affinity_rules = (known after apply)
             + placement_group_id  = (known after apply)
           }
    
         + resources {
             + core_fraction = 100
             + cores         = 2
             + memory        = 2
           }
    
         + scheduling_policy {
             + preemptible = (known after apply)
           }
           }
    
     # yandex_vpc_network.default will be created
     + resource "yandex_vpc_network" "default" {
         + created_at                = (known after apply)
         + default_security_group_id = (known after apply)
         + folder_id                 = (known after apply)
         + id                        = (known after apply)
         + labels                    = (known after apply)
         + name                      = "net"
         + subnet_ids                = (known after apply)
       }
    
     # yandex_vpc_subnet.default will be created
     + resource "yandex_vpc_subnet" "default" {
         + created_at     = (known after apply)
         + folder_id      = (known after apply)
         + id             = (known after apply)
         + labels         = (known after apply)
         + name           = "subnet"
         + network_id     = (known after apply)
         + v4_cidr_blocks = [
             + "192.168.101.0/24",
           ]
         + v6_cidr_blocks = (known after apply)
         + zone           = "ru-central1-a"
       }

   

В качестве результата задания предоставьте:

1. Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami? С помощью [Packer](https://www.packer.io/)
2. Ссылку на репозиторий с исходной конфигурацией терраформа - 
