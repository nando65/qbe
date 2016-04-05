class AddCommentaryToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commentary, :text
  end
end
