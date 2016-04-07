class AddSectionToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :section, :integer
    add_column :latte_accounts, :password, :string
  end
end
