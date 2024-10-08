class AnswersController < ApplicationController
  require "time"

  def index
    @answer = Answer.all
  end


  def create
    @question = Question.find(params[:question_id])
    @pulse = @question.pulse_category.pulse
    @answer = Answer.new(answer_params)
    @answer.question = @question

    if params[:answer][:start_time].present?
      start_time_ms = params[:answer][:start_time].to_i
      @start_time = Time.at(start_time_ms / 1000.0) # Convert to seconds and create Time object
      @answer.duration_spent = Time.now - @start_time
    else
      @answer.duration_spent = 0 # Default value if start_time is not provided
    end
    # @answer.user = current_user

    if @answer.save
      @next_question = Question.find_by(id: @question.id + 1)
      if @next_question && @next_question.pulse_category.pulse == @pulse
        redirect_to question_path(@next_question)
      else
        redirect_to root_path, notice: "You have completed all the questions."
      end
    else
      flash[:error] = @answer.errors.full_messages.join(', ')
      redirect_to question_path(@question), status: :unprocessable_entity
    end
  end


  private

  def answer_params
    params.require(:answer).permit(:content, :start_time)
  end
end
