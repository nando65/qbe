class AddLevelToAffinities < ActiveRecord::Migration
  def change
    add_column :affinities, :level, :int
  end
end
