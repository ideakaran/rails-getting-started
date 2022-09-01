class Division < ApplicationRecord
  belongs_to :game
  has_many :teams
  belongs_to :user
end
