class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|

      t.integer :follower_id, null: false
      t.integer :subject_id, null: false
      t.belongs_to :affinity

      t.timestamps null: false
    end
  end
end
