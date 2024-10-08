class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!
  allow_browser versions: :modern

  # before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def evaluate_cv
    if user_signed_in? && current_user.cv.attached?
      cv_content = extract_text_from_cv(current_user.cv)
      evaluation = evaluate_cv_content(cv_content)
      # Assuming you have a way to store the evaluation, like a column or a method to handle it.
      current_user.update(cv_evaluation: evaluation) # Ensure cv_evaluation is a field in the User model or handle it in memory.
    end
  end

  def evaluate_cv_content(cv_content)
    client = OpenAI::Client.new
    response = client.chat(parameters:
    {
      model: "gpt-4",
      messages: [{ role: "user", content: "Evaluate this CV: #{cv_content}" }]
    })
    response['choices'][0]['message']['content']
  end
end
