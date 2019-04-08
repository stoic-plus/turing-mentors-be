class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.integer :day_of_week
      t.boolean :morning
      t.boolean :afternoon
      t.boolean :evening
      t.references :user, foreign_key: true
    end
  end
end
