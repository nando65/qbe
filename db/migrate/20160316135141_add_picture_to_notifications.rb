class AddPictureToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :picture, :bytea
  end
end
