class LatteAccount < ApplicationRecord
  
  validates :name, :user_id, presence: true
  has_secure_password
  belongs_to :user
end
