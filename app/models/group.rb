class Group < ApplicationRecord
  attr_accessor :name
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :homeworks
  has_and_belongs_to_many :users
end
