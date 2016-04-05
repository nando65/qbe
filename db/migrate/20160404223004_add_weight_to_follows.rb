class AddWeightToFollows < ActiveRecord::Migration
  def change
    add_column :follows, :weight, :integer
  end
end
