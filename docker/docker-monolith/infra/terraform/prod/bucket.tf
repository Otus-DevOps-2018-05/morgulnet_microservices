terraform {
  backend "gcs" {
    bucket = "storage-mo-microservices"
    prefix = "docker"
  }
}
