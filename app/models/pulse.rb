class Pulse < ApplicationRecord
  belongs_to :user
  has_many :pulse_categories
  has_many :categories, through: :pulse_categories
  has_many :questions, through: :pulse_categories
  # has_one_attatched :file
  after_create :create_questions, unless: :seeding?

  # validates :job_role, presence: true
  # validates :job_description, presence: true
  # validates :company_name, presence: true
  # validates :company_description, presence: true
  def seeding?
    ENV["SEEDING"] == 'true'
  end

  private

  def create_questions
    return if pulse_categories.blank?

    pulse_categories.each do |pulse_category|
      5.times do
        Question.create!(pulse_category: pulse_category)
      end
    end
  end

end
