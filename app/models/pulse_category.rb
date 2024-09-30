class PulseCategory < ApplicationRecord
  belongs_to :pulse
  belongs_to :category
  has_many :questions
  validates :pulse_id, presence: true
  validates :category_id, presence: true
end
