class AddAttrToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :facebook_id, null: true
      t.text :biography
      t.string :phone
      t.date :birthdate
      t.string :gender, default: 'male'
      t.string :facebook_link
      t.string :fb_token
    end
  end
end
