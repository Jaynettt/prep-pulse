class Answer < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates :evaluation, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }, allow_nil: true

  after_create :rate_answer, if: :rating_absent?

  private

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
