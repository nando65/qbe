class AddAdviseToAdvises < ActiveRecord::Migration
  def change
    add_column :advises, :advise, :text
  end
end
