class RemoveEndFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :end, :date
  end
end
