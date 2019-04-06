class AddIdentityIdToUserIdentities < ActiveRecord::Migration[5.2]
  def change
    add_reference(:user_identities, :identity, foreign_key: {to_table: :identities})
  end
end
