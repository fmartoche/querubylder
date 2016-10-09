json.extract! query, :id, :dimensions, :metrics, :conditions, :created_at, :updated_at
json.url query_url(query, format: :json)