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

