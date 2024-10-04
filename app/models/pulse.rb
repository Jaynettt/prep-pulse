class Pulse < ApplicationRecord

  belongs_to :user
  has_many :pulse_categories
  has_many :categories, through: :pulse_categories
  # has_one_attatched :file
  after_save :create_questions, unless: :seeding?

  # validates :job_role, presence: true
  # validates :job_description, presence: true
  # validates :company_name, presence: true
  # validates :company_description, presence: true
  def seeding?
    ENV["SEEDING"] == 'true'
  end


  def create_questions
    5.times do
      Question.create!(pulse_category_id: self.pulse_categories.sample.id)
    end
  end
end
