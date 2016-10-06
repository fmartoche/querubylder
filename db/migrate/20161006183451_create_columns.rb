class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
      t.string :name
      t.string :type
      t.references :table, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
