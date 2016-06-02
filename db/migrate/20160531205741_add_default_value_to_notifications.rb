class AddDefaultValueToNotifications < ActiveRecord::Migration
  def up
  change_column :notifications, :unread, :boolean, :default => true
end

def down
  change_column :notifications, :unread, :boolean, :default => nil
end
end
