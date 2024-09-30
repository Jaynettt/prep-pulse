class PulseCategory < ApplicationRecord
  belongs_to :category
  belongs_to :pulse
  has_many :questions
end
