class Question < ApplicationRecord
  belongs_to :pulse_category
  has_many :answers
  after_save :content, unless: :seeding?

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

    private
    def set_content
        client = OpenAI::Client.new
        chatgpt_response = client.chat(parameters: {
          model: "gpt-4",  # Use the correct model
          messages: [{ role: "user", content: "Generate an interview question for #{pulse_category.category.name} preparations. The job is #{pulse_category.pulse.job_role}" }]
        })
        new_content = chatgpt_response["choices"][0]["message"]["content"]

        update(content: new_content)
        return new_content
    end
end
