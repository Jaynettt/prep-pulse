class AnswersController < ApplicationController
  require "time"

  def index
    @answer = Answer.all
  end

  def show
    @question = Question.find(params[:question_id])
    @pulse = @question.pulse_category.pulse
    @answer = Answer.find(params[:id])
    @formatted_duration = format_duration(@answer.duration_spent)
    @next_question = Question.find_by(id: @question.id + 1)
    @previous_question = Question.find_by(id: @question.id - 1)
    if @next_question && @next_question.pulse_category.pulse == @pulse

    else
      @next_question = nil
    end
    if @previous_question && @previous_question.pulse_category.pulse == @pulse

    else
      @previous_question = nil
    end
  end

  def format_duration(seconds)
    total_seconds = seconds.round
    minutes = total_seconds / 60
    seconds = total_seconds % 60
    "#{minutes} minute#{'s' if minutes != 1} and #{seconds} second#{'s' if seconds != 1}"
    # return total_seconds
  end

  def create
    @question = Question.find(params[:question_id])
    @pulse = @question.pulse_category.pulse
    @answer = Answer.new(answer_params)
    @answer.question = @question

    if params[:answer][:start_time].present?
      start_time_ms = params[:answer][:start_time].to_i
      @start_time = Time.at(start_time_ms / 1000.0)
      @answer.duration_spent = Time.now - @start_time
    else
      @answer.duration_spent = 0
    end

    # @answer.user = current_user
    if @answer.content.blank?
      @answer.content = "No answer provided"
    end

    if @answer.save
      @next_question = Question.find_by(id: @question.id + 1)
      if @next_question && @next_question.pulse_category.pulse == @pulse
        redirect_to question_path(@next_question)
      else
        redirect_to pulse_path(@pulse), notice: "You have completed all the questions."
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
