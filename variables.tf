variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "location" {
  default = "us-central1"
}

variable "index_display_name" {
  default = "faq-vector-index"
}

variable "cloud_run_service_name" {
  default = "faq-rag-service"
}

variable "docker_image" {
  description = "Cloud Run container image"
}
