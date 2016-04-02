class AddSharedPostToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :shared_post, :boolean
  end
end
