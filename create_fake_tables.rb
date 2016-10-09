users = Table.create(name: "users")
sessions = Table.create(name: "sessions")
hits = Table.create(name: "hits")
custom_dimensions = Table.create(name: "custom_dimensions")
purchases = Table.create(name: "purchases")


users.table_columns.create(name: "email", data_type: "string")
users.table_columns.create(name: "first_name", data_type: "string")
users.table_columns.create(name: "last_name", data_type: "string")
users.table_columns.create(name: "phone_number", data_type: "string")


sessions.table_columns.create(name: "start_date", data_type: "date")
sessions.table_columns.create(name: "device", data_type: "string")
sessions.table_columns.create(name: "browser", data_type: "string")
sessions.table_columns.create(name: "new_user", data_type: "boolean")
sessions.table_columns.create(name: "user_id", data_type: "string")


hits.table_columns.create(name: "type", data_type: "string")
hits.table_columns.create(name: "hit_time", data_type: "datetime")
hits.table_columns.create(name: "eventCategory", data_type: "string")
hits.table_columns.create(name: "eventAction", data_type: "string")
hits.table_columns.create(name: "fullpath", data_type: "string")
hits.table_columns.create(name: "session_id", data_type: "string")
hits.table_columns.create(name: "user_id", data_type: "string")


custom_dimensions.table_columns.create(name: "hit_id", data_type: "string")
custom_dimensions.table_columns.create(name: "dimension_name", data_type: "integer")
custom_dimensions.table_columns.create(name: "value", data_type: "string")


purchases.table_columns.create(name: "user_id", data_type: "integer")
purchases.table_columns.create(name: "amount", data_type: "integer")
purchases.table_columns.create(name: "purchase_date", data_type: "date")