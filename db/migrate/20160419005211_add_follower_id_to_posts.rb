class AddFollowerIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :follower_id, :integer
  end
end
