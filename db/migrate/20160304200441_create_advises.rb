class CreateAdvises < ActiveRecord::Migration
  def change
    create_table :advises do |t|

      t.integer :gives_advice_to, null: false
      t.integer :receives_advice_from, null: false

      t.timestamps null: false
    end
  end
end
