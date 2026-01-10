# Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"  # Replace with your GCP project ID
  region  = "us-central1"
  zone    = "us-central1-a"
}

# Create a VPC network
resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc-network"
  auto_create_subnetworks = true
}

# Create a firewall rule to allow SSH, HTTP, and HTTPS traffic
resource "google_compute_firewall" "default_firewall" {
  name    = "default-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]  # Warning: This allows access from any IP (for demo only)
}

# Create a VM instance
resource "google_compute_instance" "vm_instance" {
  name         = "my-vm-instance"
  machine_type = "e2-medium"  # You can change this to other types like n1-standard-1

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # OS image
      size  = 20  # Disk size in GB
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    sudo systemctl start nginx
  EOF

  tags = ["http-server", "https-server"]
}

# Output the external IP address of the instance
output "instance_external_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}