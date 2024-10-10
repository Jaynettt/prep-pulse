class Pulse < ApplicationRecord
  belongs_to :user
  has_many :pulse_categories
  has_many :categories, through: :pulse_categories
  has_many :questions, through: :pulse_categories
  after_create :create_questions, unless: :seeding?
  # after_save :create_questions, if: :categories_changed?

  # # validates :job_role, presence: true
  # # validates :job_description, presence: true

  # def categories_changed?
  #   # Check if the associated pulse categories have changed
  #   pulse_categories.loaded? && (pulse_categories.pluck(:id) != previous_pulse_categories_ids)
  # end

  # def previous_pulse_categories_ids
  #   # This returns the IDs of the pulse categories before the save
  #   @previous_pulse_categories_ids ||= PulseCategory.where(pulse_id: id).pluck(:category_id)
  # end

  def seeding?
    ENV["SEEDING"] == 'true'
  end

  private

  def create_questions
    SetPulseQuestionsJob.perform_later(self)


  end

end
