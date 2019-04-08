class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :cohort
      t.boolean :active, default: true
      t.string :program
      t.string :current_job, default: "student"
      t.text :background
      t.string :location, default: "Denver, CO"

      t.timestamps
    end
  end
end
