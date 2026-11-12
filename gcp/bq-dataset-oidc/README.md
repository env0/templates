Creates a BigQuery dataset, authenticated with an env0 `GCP_OIDC` deployment credential (Workload Identity Federation) instead of a service-account key.

It needs:

- A `GCP_OIDC` credential as the project's default GCP deployment credential. Its service account needs `bigquery.datasets.create`, `bigquery.datasets.get` and `bigquery.datasets.delete`.
- `GOOGLE_PROJECT` - The GCP project to create the dataset in.
