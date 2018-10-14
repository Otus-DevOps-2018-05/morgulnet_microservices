variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used to connect to instance"
}

variable docker_base_disk_image {
  description = "Disk image for reddit app"
  default     = "docker-base"
}

variable "count" {
  description = "Number of docker host"
  default     = 1
}
