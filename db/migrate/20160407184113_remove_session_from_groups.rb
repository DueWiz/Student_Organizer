class RemoveSessionFromGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :session, :integer
    remove_column :latte_accounts, :password_digest, :integer
  end
end
