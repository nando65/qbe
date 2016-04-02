class CreateEndorses < ActiveRecord::Migration
  def change
    create_table :endorses do |t|

      t.integer :follower_id, null: false
      t.integer :subject_id, null: false
      t.belongs_to :endorsement


      t.timestamps null: false
    end
  end
end
