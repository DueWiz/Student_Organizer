class Group < ApplicationRecord
  TERMS = %i[Spring Summer Fall]
  validates :name, presence: true
  validates :year, presence: true
  validates :term, presence: true
  validates :section, presence: true

  has_many :homeworks
  has_many :group_users
  has_many :users, through: :group_users
end
