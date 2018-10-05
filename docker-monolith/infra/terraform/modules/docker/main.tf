resource "google_compute_instance" "docker" {
  name         = "docker-base-${count.index+1}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["docker-base"]
  count        = "${var.count}"
  
  boot_disk {
    initialize_params {
      image = "${var.docker_base_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.docker_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_address" "docker_ip" {
  name = "docker-ip"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["docker-base"]
}
