class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :latte_account
  has_many :user_homeworks
  has_many :homeworks, through: :user_homeworks
  has_many :group_users
  has_many :groups, through: :group_users
end
