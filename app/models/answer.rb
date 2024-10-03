class Answer < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates :evaluation, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  # validates :chat_review, presence: true
end
