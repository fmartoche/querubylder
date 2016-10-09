class CreateTableColumns < ActiveRecord::Migration
  def change
    create_table :table_columns do |t|
      t.string :name
      t.string :data_type
      t.references :table, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
