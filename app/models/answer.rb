class Answer < ApplicationRecord
  belongs_to :question
  # validates :content, presence: true
  validates :evaluation, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  # validates :chat_review, presence: true
  after_create :chat_review, unless: :seeding?
  after_create :rate_answer, if: :rating_absent?

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

  def rating_absent?
    evaluation.nil?
  end

  def rate_answer
    client = OpenAI::Client.new
    response = client.chat(parameters: {
      model: "gpt-4",
      messages: [
        { role: "user", content: "Rate the following answer on a scale of 1 to 10: '#{content}'. Give me only the number." }
      ]
    })
    
    new_evaluation = response["choices"][0]["message"]["content"].to_i

    # Ensure the rating is within 1 and 10
    if new_evaluation.between?(1, 10)
      update!(evaluation: new_evaluation) # Persist the new evaluation
    end

  end
end
