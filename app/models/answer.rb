class Answer < ApplicationRecord
  belongs_to :question
  validates :content, presence: true
  # validates :chat_review, presence: true
end
