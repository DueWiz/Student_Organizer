class Homework < ApplicationRecord
  validates :name, presence: true

  has_many :user_homeworks
  belongs_to :group
  has_many :users, through: :user_homeworks
end
