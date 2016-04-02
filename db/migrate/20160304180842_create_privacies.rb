class CreatePrivacies < ActiveRecord::Migration
  def change
    create_table :privacies do |t|



      t.timestamps null: false
    end
  end
end
