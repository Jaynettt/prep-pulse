class Question < ApplicationRecord
  belongs_to :pulse_category
  has_many :answers
  validates :content, presence: true, length: { maximum: 500 }
end
