variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable private_key_path {
  description = "Path to the private key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable docker_base_disk_image {
  description = "Disk image for reddit app"
  default     = "docker-base"
}

variable "count" {
  description = "Number of docker host"
  default     = 1
}

variable app_provision {
  description = "Provision instance with app"
  default     = "true"
}
