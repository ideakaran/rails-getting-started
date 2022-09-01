class Game < ApplicationRecord
  has_many :divisions
  belongs_to :user
end
