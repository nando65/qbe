class RemovePictureFromNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :picture, :bytea
  end
end
