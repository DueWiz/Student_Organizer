class CreateUserHomeworks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_homeworks do |t|
      t.integer :user_id
      t.integer :homework_id
      t.string :status
      t.string :grade
      t.string :comment

      t.timestamps
    end
  end
end
