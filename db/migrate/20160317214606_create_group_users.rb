class CreateGroupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :group_users do |t|
      create_table :groups_users, id: false do |t|
        t.belongs_to :group, index: true
        t.belongs_to :user, index: true
      end
      t.timestamps
    end
  end
end
