class CreateContactDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_details do |t|
      t.string :email
      t.string :slack
      t.string :linkedin
      t.string :phone
      t.integer :preferred_method, default: 1
    end
  end
end
