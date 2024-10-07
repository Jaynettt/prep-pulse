class QuestionsController < ApplicationController
  def index
    pulse_category = PulseCategory.find(params[:pulse_category_id])
    @questions = pulse_category.questions
    # redirect_to question_path(@question)
  end

  def show
    @question = Question.find(params[:id])
    if @question.nil?
      redirect_to questions_path, alert: "Question not found."
    else
      @answer = Answer.new
    end
  end

end
