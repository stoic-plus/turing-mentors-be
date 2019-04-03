class AddMentorToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mentor, :boolean, default: false
  end
end
