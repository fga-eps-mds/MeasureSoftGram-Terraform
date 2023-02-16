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

resource "docker_image" "postgres" {
  name         = "postgres:latest"
  keep_locally = true
}

resource "docker_image" "msg-service-image" {
  name         = "test:latest"
  keep_locally = true
}

resource "docker_image" "front" {
  name         = "francisco1code/2022-2-measuresoftgram-front:latest"
  keep_locally = true
}


resource "docker_container" "front" {
  name    = "front"
  image   = docker_image.front.image_id
  network_mode = docker_network.example.name
  must_run = true

  env = [
    "SERVICE_URL=${var.SERVICE_URL}",
    "NEXT_PUBLIC_API_URL=${var.NEXT_PUBLIC_API_URL}",
    "LOGIN_REDIRECT_URL=${var.LOGIN_REDIRECT_URL}",
    "GITHUB_CLIENT_ID=${var.GITHUB_CLIENT_ID}",
    "GITHUB_SECRET=${var.GITHUB_SECRET}"
  ]

  ports {
    external = 3000
    internal = 3000
  }
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
  
  env = [
    "POSTGRES_HOST=${var.POSTGRES_HOST}",
    "POSTGRES_DB=${var.POSTGRES_DB}",
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PORT=${var.POSTGRES_PORT}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}",
    "DEBUG=TRUE",
    "CREATE_FAKE_DATA=TRUE",
    "LOGIN_REDIRECT_URL=${var.LOGIN_REDIRECT_URL}",
    "GITHUB_CLIENT_ID=${var.GITHUB_CLIENT_ID}",
    "GITHUB_SECRET=${var.GITHUB_SECRET}"
  ]

  command = ["./start_service.sh"]

  ports {
    internal = 80
    external = 8080
  }
}

resource "docker_container" "postgres" {
  name    = "db"
  image   = docker_image.postgres.image_id
  network_mode = docker_network.example.name
  must_run = true

  env = [
    "POSTGRES_HOST=${var.POSTGRES_HOST}",
    "POSTGRES_DB=${var.POSTGRES_DB}",
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PORT=${var.POSTGRES_PORT}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}"
  ]

  ports {
    external = 5432
    internal = 5555
  }
}



