class UserHomework < ApplicationRecord
  
  validates :user_id, :homework_id, presence: true
  belongs_to :user
  belongs_to :homework
end
