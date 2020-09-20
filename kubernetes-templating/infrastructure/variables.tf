variable project {
  description = "Project"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable cluster_name {
  description = "Cluster name"
}

variable cluster_node_count {
  description = "Node count in the Cluster"
  default     = 3
}

variable cluster_node_machine_type {
  description = "Node machine type in the Cluster"
  default     = "n1-standard-1"
}

variable cluster_node_disk_size_gb {
  description = "Node machine disk size (Gb)"
  default     = 100
}

variable second_pool_node_count {
  description = "Node count in the Second Pool"
}

variable second_pool_node_machine_type {
  description = "Node machine type in the Second Pool"
}

variable second_pool_node_disk_size_gb {
  description = "Node machine disk size (Gb) in the Second Pool"
}
