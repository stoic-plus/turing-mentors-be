class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :cohort
      t.boolean :active, default: true
      t.string :program
      t.string :current_job
      t.text :background
      t.string :location

      t.timestamps
    end
  end
end
