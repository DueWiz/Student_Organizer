class Homework < ApplicationRecord
  validates :name, :due_date, presence: true

  has_many :user_homeworks

  has_many :users, through: :user_homeworks
end
