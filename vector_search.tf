resource "google_vertex_ai_index" "vector_index" {
  display_name = var.index_display_name
  description  = "Vector Search index for FAQ RAG"

  index_update_method = "BATCH_UPDATE"

  metadata = jsonencode({
    contentsDeltaUri = "gs://your_bucket/embeddings/"
    config = {
      dimensions        = 768
      approximateNeighbors = {
        algorithmConfig = {
          treeAhConfig = {
            leafNodesToSearchPercent = 10
          }
        }
      }
    }
  })

  region  = var.region
  project = var.project_id
}

resource "google_vertex_ai_index_endpoint" "index_endpoint" {
  display_name = "faq-vector-index-endpoint"
  project      = var.project_id
  region       = var.region
}

resource "google_vertex_ai_index_endpoint_deployed_index" "deployed_index" {
  index_endpoint = google_vertex_ai_index_endpoint.index_endpoint.name
  index          = google_vertex_ai_index.vector_index.name
  deployed_index_id = "faq-deployed-index"

  dedicated_resources = {
    min_replica_count = 1
    max_replica_count = 2
    machine_spec = {
      machine_type = "e2-standard-4"
    }
  }
}
