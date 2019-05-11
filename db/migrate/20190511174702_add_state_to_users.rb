class AddStateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :state, :string, default: "CO"
  end
end
