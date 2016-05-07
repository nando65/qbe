class AddProblemToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :problem, :text
  end
end
