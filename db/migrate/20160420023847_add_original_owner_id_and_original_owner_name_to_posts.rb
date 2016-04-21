class AddOriginalOwnerIdAndOriginalOwnerNameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :original_owner_id, :integer
    add_column :posts, :original_owner_name, :string
  end
end
