class AddAasmStateToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :aasm_state, :string, default: "created"
  end
end
