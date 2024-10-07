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
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
    model: "gpt-4",  # Use the correct model
    messages: [{ role: "user", content: "Give some constructive feedback for this answer #{content}. The interview question was #{question.content}"}]
    })
    new_chat_review = chatgpt_response["choices"][0]["message"]["content"]

    update(chat_review: new_chat_review)
    return new_chat_review
  end
end
