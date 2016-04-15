class AddAffinityDescriptionToAffinities < ActiveRecord::Migration
  def change
    add_column :affinities, :affinity_description, :text
  end
end
