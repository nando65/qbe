class AddFollowerIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :follower_id, :integer
  end
end
