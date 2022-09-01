class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :user_type, presence: true

  has_secure_password
  has_many :teams
  has_many :divisions
  has_many :games

end
