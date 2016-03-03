class CreateHomeworks < ActiveRecord::Migration[5.0]
  def change
    create_table :homeworks do |t|
      t.string :name
      t.datetime :due_date
      t.integer :group_id

      t.timestamps
    end
  end
end
