class AddPaperclipToPost < ActiveRecord::Migration

  add_attachment :posts, :image

  def change
  end
end
