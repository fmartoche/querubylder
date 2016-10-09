class CreateAllowedInputs < ActiveRecord::Migration
  def change
    create_table :allowed_inputs do |t|
      t.string :name
      t.string :input_type
      t.string :alias

      t.timestamps null: false
    end
  end
end
