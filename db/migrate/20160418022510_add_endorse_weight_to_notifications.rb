class AddEndorseWeightToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :endorse_weight, :integer
  end
end
