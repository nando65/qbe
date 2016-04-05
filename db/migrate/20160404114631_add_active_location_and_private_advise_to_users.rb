class AddActiveLocationAndPrivateAdviseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_location, :boolean, default: true
    add_column :users, :private_advise, :boolean, default: false
  end
end
