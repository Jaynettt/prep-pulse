class PulseCategory < ApplicationRecord
  belongs_to :pulse
  has_many :questions
  belongs_to :category
end
