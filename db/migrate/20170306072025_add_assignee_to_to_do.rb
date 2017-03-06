class AddAssigneeToToDo < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :assignee, :string, default: "未指派"
  end
end
