output "cloud_run_url" {
  value = google_cloud_run_service.rag_api.status[0].url
}

output "index_endpoint" {
  value = google_vertex_ai_index_endpoint.index_endpoint.name
}
