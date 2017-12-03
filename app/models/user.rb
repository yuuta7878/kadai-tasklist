# バリデーション
class User < ApplicationRecord
  # テーブルに保存される全てのメアドは小文字に変換される
  before_save { self.email.downcase! } 
  # nameのvalidation カラを許さず50文字以内
  validates :name, presence: true, length: { maximum: 50 } 
  # emailのvalidation " 255文字以内
  validates :email, presence: true, length: { maximum: 255 }, 
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, # メアドの正しい形式
                    uniqueness: { case_sensitive: false } # 重複を許さないバリデーション(大文字&小文字を区別しない)
  has_secure_password
end
