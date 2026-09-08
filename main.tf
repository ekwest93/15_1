# Сеть
resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

# Публичная подсеть
resource "yandex_vpc_subnet" "subnet-public" {
  name           = "public"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# Таблица маршрутизации
resource "yandex_vpc_route_table" "nat-route-table" {
  name       = "nat-route-table"
  network_id = yandex_vpc_network.network-1.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

# Приватная подсеть (сразу с маршрутом)
resource "yandex_vpc_subnet" "subnet-private" {
  name           = "private"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.nat-route-table.id
}

# NAT-инстанс
resource "yandex_compute_instance" "nat-instance" {
  name        = "nat-instance-vm1"
  platform_id = "standard-v2"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
      size     = 20
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-public.id
    ip_address = "192.168.10.254"
    nat        = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_ssh_key}"
    user-data = "#cloud-config\npassword: ubuntu123\nchpasswd: { expire: False }\nssh_pwauth: True\n"
  }
}

# Публичная ВМ
resource "yandex_compute_instance" "public-vm" {
  name        = "public-vm1"
  platform_id = "standard-v2"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-public.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_ssh_key}"
    user-data = "#cloud-config\npassword: ubuntu123\nchpasswd: { expire: False }\nssh_pwauth: True\n"
  }
}

# Приватная ВМ
resource "yandex_compute_instance" "private-vm" {
  name        = "private-vm1"
  platform_id = "standard-v2"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-private.id
    nat       = false
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_ssh_key}"
    user-data = "#cloud-config\npassword: ubuntu123\nchpasswd: { expire: False }\nssh_pwauth: True\n"
  }
}
