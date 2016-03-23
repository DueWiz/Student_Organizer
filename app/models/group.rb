class Group < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :homeworks
  has_many :group_users
  has_many :users, through: :group_users
end
