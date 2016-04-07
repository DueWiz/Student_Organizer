class LatteAccount < ApplicationRecord

  validates :name, :user_id, presence: true
  attr_encrypted :password, key: :encryption_key
  def encryption_key
      SecureRandom.base64(32)
  end

  belongs_to :user
end
