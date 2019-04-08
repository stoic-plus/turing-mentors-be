class CreateUserIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_identities do |t|
      t.references :user, foreign_key: true
    end
  end
end
