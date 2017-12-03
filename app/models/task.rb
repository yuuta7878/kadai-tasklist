class Task < ApplicationRecord
  belongs_to :user
  
  validates :content, :user, presence: true, length: { maximum: 255 }
  validates :status, :user, presence: true, length: { maximum: 10 }
end