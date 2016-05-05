class AddStatusToLatteAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :latte_accounts, :status, :boolean
  end
end
