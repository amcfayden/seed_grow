class CreateSeeds < ActiveRecord::Migration
  def change
    create_table :seeds do |t|
      t.string :plant
      t.string :source
      t.integer :user_id

      t.timestamps
    end
    add_index :seeds, [:user_id, :created_at]
  end
end
