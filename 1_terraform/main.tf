terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.18"
    }
  }
}

provider "google" {
  credentials = file("./setup/credentials.json")
  project = var.project_id
  region  = var.region
}

# Storage Buckets
resource "google_storage_bucket" "raw" {
  name          = "ny-taxi-raw"
  location      = "US"
  storage_class = "STANDARD"
}

resource "google_storage_bucket" "processed" {
  name          = "ny-taxi-processed"
  location      = "US"
  storage_class = "STANDARD"
}

# BigQuery Dataset
resource "google_bigquery_dataset" "ny_taxi" {
  dataset_id    = "ny_taxi_dataset"
  friendly_name = "NY Taxi Dataset"
  location      = "US"
}

# BigQuery Table
resource "google_bigquery_table" "ny_taxi" {
  dataset_id          = google_bigquery_dataset.ny_taxi.dataset_id
  table_id            = "ny_taxi"
  schema              = file("${path.module}/schema/ny_taxi_schema.json")
  deletion_protection = false
}

# Dataproc Cluster (Updated)
resource "google_dataproc_cluster" "ny_taxi_processing" {
  name   = "ny-taxi-processing"
  region = var.region

  cluster_config {
    master_config {
      num_instances = 1
      machine_type  = "n1-standard-2"
      
      disk_config {
        boot_disk_size_gb = 200  # Reduce from default (500GB)
      }
    }

    worker_config {
      num_instances = 2 # Initial number of instances
      machine_type  = "n1-standard-2"
      
      disk_config {
        boot_disk_size_gb = 200  # Reduce from default (500GB)
      }
    }

    autoscaling_config {
      policy_uri = google_dataproc_autoscaling_policy.basic.id
    }

    software_config {
      image_version       = "2.0"
      optional_components = ["JUPYTER"]
    }
  }
}

# Autoscaling Policy (Updated)
resource "google_dataproc_autoscaling_policy" "basic" {
  policy_id = "dataproc-policy"
  location  = "us-central1"

  worker_config {
    min_instances = 2
    max_instances = 10 # Correct attribute name
  }

  basic_algorithm {
    yarn_config {
      graceful_decommission_timeout = "30s"
      scale_up_factor               = 0.05
      scale_down_factor             = 0.05
    }
  }
}

resource "google_dataproc_autoscaling_policy" "basic2" {
  policy_id = "another-dataproc-policy"
  location  = "us-east1"

  worker_config {
    min_instances = 2
    max_instances = 10
  }

  basic_algorithm {
    yarn_config {
      graceful_decommission_timeout = "30s"
      scale_up_factor               = 0.05
      scale_down_factor             = 0.05
    }
  }
}
