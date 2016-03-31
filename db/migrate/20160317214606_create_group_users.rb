class CreateGroupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :group_users do |t|
      t.references :user
      t.references :group
      t.boolean :admin, null: false, default: false
      t.timestamps null: false
    end
  end
end
