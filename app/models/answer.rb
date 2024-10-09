class Answer < ApplicationRecord
  belongs_to :question
 
  # validates :content, presence: true
  # validates :evaluation, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  # validates :chat_review, presence: true
  after_create :chat_review, unless: :seeding?
  

  # validates :content, presence: true, length: { maximum: 500 }

  def seeding?
    ENV["SEEDING"] == 'true'
  end

  def chat_review
    if super.blank?
      set_chat_review
    else
      super
    end
  end

  private

  def set_chat_review
    SetChatReviewJob.perform_later(self)
  end

  def rating_absent?
    evaluation.nil?
  end

end
