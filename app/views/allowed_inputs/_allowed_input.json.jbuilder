json.extract! allowed_input, :id, :name, :input_type, :alias, :created_at, :updated_at
json.url allowed_input_url(allowed_input, format: :json)