class CreateUserHomeworks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_homeworks do |t|
      t.integer :user_id
      t.integer :homework_id
      t.string :status
      t.string :grade
      t.string :comment
      t.boolean :admin, null: false, default: false
      t.timestamps
    end
  end
end
