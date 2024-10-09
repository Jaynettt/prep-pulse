class Question < ApplicationRecord
  belongs_to :pulse_category
  has_many :answers
  after_create :content, unless: :seeding?

  # validates :content, presence: true, length: { maximum: 500 }

  def seeding?
    ENV["SEEDING"] == 'true'
  end

  def content
    if super.blank?
      set_content
    else
      super
    end
  end

  def average_answer_rating
    total = 0
    answers.each do |answer|
      total += answer.evaluation
    end
    return total.fdiv(answers.count)
  end

  private

  def set_content
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters:
    {
      model: "gpt-4",
      messages: [{ role: "user", content: "Generate an interview question for #{pulse_category.category.name} preparations. The job is #{pulse_category.pulse.job_role}. Here are the previous questions: #{pulse_category.questions.each { |question| puts question } if pulse_category.questions}. Please make it different to the previous questions. Only give me the question, none of your own input like: here is a question" }]
    })
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    update(content: new_content)
    return new_content
  end
end
