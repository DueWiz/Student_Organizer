class AddNoteToUserHomeworks < ActiveRecord::Migration[5.0]
  def change
    add_column :user_homeworks, :note, :string
  end
end
