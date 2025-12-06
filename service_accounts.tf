resource "google_service_account" "rag_sa" {
  account_id   = "rag-faq-sa"
  display_name = "RAG FAQ Service Account"
}

resource "google_project_iam_member" "rag_sa_vertex_ai" {
  project = var.project_id
  role    = "roles/aiplatform.admin"
  member  = "serviceAccount:${google_service_account.rag_sa.email}"
}

resource "google_project_iam_member" "rag_sa_storage" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.rag_sa.email}"
}
