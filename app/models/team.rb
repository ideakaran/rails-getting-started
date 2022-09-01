class Team < ApplicationRecord
  belongs_to :division
  belongs_to :user
end
