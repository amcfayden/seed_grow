class AddZoneToSeeds < ActiveRecord::Migration
  def change
    add_column :seeds, :zone, :integer
  end
end
