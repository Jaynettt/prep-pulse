class Question < ApplicationRecord
  belongs_to :pulse_category
  has_many :answers
end
