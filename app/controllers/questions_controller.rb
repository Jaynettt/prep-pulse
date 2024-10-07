class QuestionsController < ApplicationController
  def index
    pulse_category = PulseCategory.find(params[:pulse_category_id])
    @questions = pulse_category.questions
    # redirect_to question_path(@question)
  end

  def show
    @pulse = Pulse.find(params[:pulse_id])
    @pulse_category = PulseCategory.find(params[:pulse_category_id])
    @question = Question.find(params[:id])
    if @question.nil?
      redirect_to questions_path, alert: "Question not found."
    else
      @answer = Answer.new
      @next_question = @pulse_category.questions.where('id > ?', @question.id).first
    end
  end

end
