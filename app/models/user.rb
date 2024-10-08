class User < ApplicationRecord
  has_many :pulses
  has_one_attached :cv
  # validate :cv_format_validation
  after_create :evaluate_cv,  unless: :seeding?
  validates :cv_evaluation, presence: true, length: { maximum: 500 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def seeding?
    ENV["SEEDING"] == 'true'
  end

  private

  def cv_format_validation
    if cv.attached? && !cv.content_type.in?(%w(application/pdf))
      errors.add(:cv, 'must be a PDF')
    elsif cv.attached? == false
      errors.add(:cv, 'must be attached')
    end
  end

  # def evaluate_cv
  #   if @user.cv.attached?
  #     cv_content = extract_text_from_cv(@user.cv)
  #     evaluation = evaluate_cv_content(cv_content)
  #     @user.update(cv_evaluation: evaluation)
  #   end
  # end

  # def evaluate_cv_content(cv_content)
  #   client = OpenAI::Client.new
  #   response = client.chat(parameters:
  #   {
  #     model: "gpt-4",
  #     messages: [{ role: "user", content: "Please evaluate this CV: #{cv_content}" }]
  #   })
  #   response['choices'][0]['message']['content']
  # end
end
