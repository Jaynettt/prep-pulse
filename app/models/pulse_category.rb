class PulseCategory < ApplicationRecord
  belongs_to :category
  belongs_to :pulse
end
