class AddPersonSharingAndPersonSharingIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :person_sharing, :string
    add_column :posts, :person_sharing_id, :integer
  end
end
