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
  name         = "service_service:latest"
  keep_locally = true
}

resource "docker_image" "msg-core-image" {
  name         = "core_core:latest"
  keep_locally = true
}


resource "docker_container" "nginx" {
  name    = "nginx"
  image   = docker_image.nginx.image_id
  network_mode = docker_network.example.name
  must_run = true

  command = [
    "tail",
    "-f",
    "/dev/null"
  ]

  ports {
    external = 8081
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
    external = 8080
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
    internal = 80
  }
}

