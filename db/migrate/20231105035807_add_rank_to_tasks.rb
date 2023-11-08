class AddRankToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :rank, :integer
  end
end
