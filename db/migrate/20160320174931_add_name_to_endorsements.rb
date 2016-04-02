class AddNameToEndorsements < ActiveRecord::Migration
  def change
    add_column :endorsements, :name, :string
  end
end
