class ChangeCloumnsNotnullAddNames < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :name, false
    change_column_null :tasks, :detail, false
  end
end
