class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|

      t.timestamps null: false
    end
  end
end
