class AddHomeworkUserRefToUserHomeworks < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_homeworks, :homework_id, :integer
    remove_column :user_homeworks, :user_id, :integer
    add_reference :user_homeworks, :user, foreign_key: true
    add_reference :user_homeworks, :homework, foreign_key: true
  end
end
