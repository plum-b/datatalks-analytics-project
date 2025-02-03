variable "credentials_file" {
  type        = string
  description = "Path to the GCP service account credentials JSON."
}

variable "project_id" {
  type        = string
  description = "Google Cloud project ID."
}

variable "region" {
  type        = string
  description = "Region for resources."
  default     = "us-central1"
}

variable "bucket_raw_name" {
  type        = string
  description = "Unique name for raw GCS bucket."
}

variable "bucket_processed_name" {
  type        = string
  description = "Unique name for processed GCS bucket."
}

variable "dataset_id" {
  type        = string
  description = "BigQuery dataset ID."
  default     = "ny_taxi_data"
}

variable "service_account_id" {
  type        = string
  description = "Service account ID (without domain)."
  default     = "dataproc-spark-sa"
}
