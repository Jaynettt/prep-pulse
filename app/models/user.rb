require 'open-uri'
require 'rtesseract'  # Ensure you've included the RTesseract gem in your Gemfile

class User < ApplicationRecord
  has_many :pulses
  has_one_attached :cv

  after_save :evaluate_cv, unless: :seeding?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def seeding?
    ENV["SEEDING"] == 'true'
  end

  def average_evaluation_by_category
    categories_with_evaluations = Category
      .joins(pulse_categories: :pulse)
      .where(pulses: { user_id: self.id })
      .distinct
      .pluck(:id, :name)
  
    category_averages = categories_with_evaluations.map do |category_id, category_name|
      evaluations = Answer
        .joins(question: { pulse_category: { category: :pulse_categories } })
        .joins(question: { pulse_category: :pulse })
        .where(pulse_categories: { category_id: category_id }, pulses: { user_id: self.id })
        .pluck(:evaluation)
  
      average = evaluations.any? ? evaluations.compact.sum.to_f / evaluations.size : 0
  
      [category_name, average]
    end
  
    category_averages.to_h # Return as a hash for Chartkick
  end
  

  private

  def cv_format_validation
    if cv.attached? && !cv.content_type.in?(%w(image/jpeg image/png))
      errors.add(:cv, 'must be a JPEG or PNG image')
    elsif cv.attached? == false
      errors.add(:cv, 'must be attached')
    end
  end

  def evaluate_cv
    return unless cv.attached?

    # Directly use cv.download to work with the file content
    cv_content = extract_text_from_cv(cv)
    evaluation = evaluate_cv_content(cv_content)
    update(cv_evaluation: evaluation)
  end

  def extract_text_from_cv(cv_file)
    # Create a temporary file to store the image
    Tempfile.open(['cv', '.png']) do |temp_file|
      # Write the content of the attached image to the temporary file
      temp_file.binmode
      temp_file.write(cv_file.download)
      temp_file.rewind
  
      # Use RTesseract to extract text from the temporary file
      image = RTesseract.new(temp_file.path)
      text = image.to_s  # Extracted text from the imagean
  
      text
    end
  end
  

  def evaluate_cv_content(cv_content)
    # Initialize OpenAI client and proceed with evaluation
    client = OpenAI::Client.new

    # Assuming you have a function that evaluates the CV
    response = client.chat(parameters: {
      model: "gpt-4",
      messages: [{ role: "user", content: "Evaluate this CV: #{cv_content}" }]
    })

    response['choices'][0]['message']['content']
  end
end
