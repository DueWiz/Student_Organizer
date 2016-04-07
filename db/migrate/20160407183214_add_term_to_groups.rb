class AddTermToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :term, :string
    add_column :groups, :year, :integer
    add_column :groups, :session, :integer
  end
end
