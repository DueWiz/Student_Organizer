class AddProfessorToHomeworks < ActiveRecord::Migration[5.0]
  def change
    add_column :homeworks, :professor, :string
    add_column :homeworks, :description, :string

  end
end
