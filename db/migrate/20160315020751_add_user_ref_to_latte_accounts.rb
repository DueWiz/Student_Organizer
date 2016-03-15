class AddUserRefToLatteAccounts < ActiveRecord::Migration[5.0]
  def change
    add_reference :latte_accounts, :user, foreign_key: true
  end
end
