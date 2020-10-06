terraform {
  backend "gcs" {
  }
}

provider "google" {
  credentials = "${file("./service_account_terraform_credentials.json")}"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_container_cluster" "demo_cluster" {
  name               = "${var.cluster_name}"
  location           = "${var.zone}"
  initial_node_count = "${var.cluster_node_count}"

  node_config {
    machine_type = "${var.cluster_node_machine_type}"
    disk_size_gb = "${var.cluster_node_disk_size_gb}"
  }
}

resource "google_container_node_pool" "second_pool" {
  name       = "second-pool"
  location   = "${var.zone}"
  cluster    = "${google_container_cluster.demo_cluster.name}"
  node_count = "${var.second_pool_node_count}"

  node_config {
    machine_type = "${var.second_pool_node_machine_type}"
    disk_size_gb = "${var.second_pool_node_disk_size_gb}"
  }
}
