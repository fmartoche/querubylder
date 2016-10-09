class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :dimensions
      t.string :metrics
      t.string :conditions

      t.timestamps null: false
    end
  end
end
