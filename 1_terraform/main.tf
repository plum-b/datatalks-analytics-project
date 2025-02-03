terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.18.1"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}

resource "google_storage_bucket" "raw_bucket" {
  name     = var.bucket_raw_name
  location = "US"
}

resource "google_storage_bucket" "processed_bucket" {
  name     = var.bucket_processed_name
  location = "US"
}
