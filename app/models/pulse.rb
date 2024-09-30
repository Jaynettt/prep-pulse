class Pulse < ApplicationRecord
  belongs_to :user
  has_many :pulse_categories
  has_many :categories, through: :pulse_categories

  validates :job_role, presence: true
  validates :job_description, presence: true
  validates :company_name, presence: true
  validates :company_description, presence: true
end
