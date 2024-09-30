class Category < ApplicationRecord
    has_many :pulse_categories
    has_many :pulses, through: :pulse_categories
    has_many :questions, through: :pulse_categories

    validates :name, presence: true, uniqueness: true
end
