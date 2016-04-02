class RemovePictureFromNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :picture, :longblob
  end
end
