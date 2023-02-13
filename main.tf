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
  name         = "francisco1code/2022-2-measuresoftgram-service:latest"
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

resource "docker_container" "postgres" {
  name    = "db"
  image   = docker_image.postgres.image_id
  network_mode = docker_network.example.name
  must_run = true

  env = [
    "POSTGRES_DB=postgres",
    "POSTGRES_USER=postgres",
    "POSTGRES_PORT=5432",
    "POSTGRES_PASSWORD=postgres"
  ]

  ports {
    external = 5432
    internal = 5432
  }
}


resource "docker_container" "msg-service-latest" {
  name    = "msg-service"
  image   = docker_image.msg-service-image.image_id
  network_mode = docker_network.example.name
  must_run = true
  
  env = [
    "POSTGRES_HOST=db",
    "POSTGRES_DB=postgres",
    "POSTGRES_USER=postgres",
    "POSTGRES_PORT=5432",
    "POSTGRES_PASSWORD=postgres",
    "GITHUB_CLIENT_ID=CL13NT1D",
    "GITHUB_SECRET=S3CR3T",
    "DEBUG=TRUE",
    "CREATE_FAKE_DATA=TRUE"
  ]

  command = ["./start_service.sh"]

  ports {
    internal = 80
  }
}
