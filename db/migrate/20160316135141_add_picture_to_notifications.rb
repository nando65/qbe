class AddPictureToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :picture, :longblob
  end
end
