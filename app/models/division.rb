class Division < ApplicationRecord
  belongs_to :game
  has_many :teams
end
