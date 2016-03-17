class AddGroupRefToHomeworks < ActiveRecord::Migration[5.0]
  def change
    remove_column :homeworks, :group_id, :integer
    add_reference :homeworks, :group, foreign_key: true
  end
end
