terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
}

provider "docker" {
}

resource "docker_network" "example" {
  name = "mynetwork"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_image" "msg-service-image" {
  name         = "2022-2-measuresoftgram-service_service"
  keep_locally = true
}

resource "docker_image" "msg-core-image" {
  name         = "2022-2-measuresoftgram-core_core"
  keep_locally = true
}


resource "docker_container" "nginx" {
  name    = "nginx"
  image   = docker_image.nginx.image_id
  network_mode = docker_network.example.name
  must_run = true

  ports {
    external = 80
    internal = 80
  }
}


resource "null_resource" "copy_nginx_conf" {
  provisioner "local-exec" {
    command = " docker cp ./nginx.conf nginx:/etc/nginx/nginx.conf"
  }
}


resource "docker_container" "msg-service-latest" {
  name    = "msg-service"
  image   = docker_image.msg-service-image.image_id
  network_mode = docker_network.example.name
  must_run = true

  command = [
    "tail",
    "-f",
    "/dev/null"
  ]

  ports {
    external = 3000
    internal = 80
  }
}

resource "docker_container" "msg-service-load-balance-latest" {
  name    = "msg-service-load-balance"
  image   = docker_image.msg-service-image.image_id
  network_mode = docker_network.example.name
  must_run = true


  command = [
    "tail",
    "-f",
    "/dev/null"
  ]

  ports {
    external = 3001
    internal = 80
  }
}


resource "docker_container" "msg-core-latest" {
  name    = "msg-core"
  image   = docker_image.msg-core-image.image_id
  network_mode = docker_network.example.name
  must_run = true

  command = [
    "tail",
    "-f",
    "/dev/null"
  ]

  ports {
    external = 5000
    internal = 5000
  }
}

resource "docker_container" "msg-core-load-balance-latest" {
  name    = "msg-core-load-balance"
  image   = docker_image.msg-core-image.image_id
  network_mode = docker_network.example.name
  must_run = true

  command = [
    "tail",
    "-f",
    "/dev/null"
  ]

  ports {
    external = 5001
    internal = 5000
  }
}

