resource "google_cloud_run_service" "rag_api" {
  name     = var.cloud_run_service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.docker_image

        env {
          name  = "INDEX_ENDPOINT"
          value = google_vertex_ai_index_endpoint.index_endpoint.name
        }
        env {
          name  = "DEPLOYED_INDEX_ID"
          value = google_vertex_ai_index_endpoint_deployed_index.deployed_index.deployed_index_id
        }
      }

      service_account_name = google_service_account.rag_sa.email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "run_invoker" {
  location = google_cloud_run_service.rag_api.location
  project  = var.project_id
  service  = google_cloud_run_service.rag_api.name

  role   = "roles/run.invoker"
  member = "allUsers"
}
