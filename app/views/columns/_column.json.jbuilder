json.extract! column, :id, :name, :type, :table_id, :created_at, :updated_at
json.url column_url(column, format: :json)