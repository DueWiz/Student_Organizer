class Homework < ApplicationRecord
  validates :name, presence: true

  has_many :user_homeworks

  has_many :users, through: :user_homeworks
end
