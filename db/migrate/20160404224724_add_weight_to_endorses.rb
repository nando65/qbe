class AddWeightToEndorses < ActiveRecord::Migration
  def change
    add_column :endorses, :weight, :integer
  end
end
