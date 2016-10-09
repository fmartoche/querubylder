json.extract! table_column, :id, :name, :type, :created_at, :updated_at
json.url table_column_url(table_column, format: :json)