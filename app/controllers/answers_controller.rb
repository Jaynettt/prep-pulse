class AnswersController < ApplicationController

  def index
    @answer =  Answer.all
  end


  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    if @answer.save
      # Find the next question
      @next_question = @question.pulse_category.questions.where('id > ?', @question.id).first
      if @next_question
        redirect_to pulse_pulse_category_question_path(@question.pulse_category.pulse, @question.pulse_category, @next_question)
      else
        redirect_to pulse_pulse_category_path(@question.pulse_category.pulse, @question.pulse_category), notice: "Congratulations! You have answered all questions."
      end
    else
      # Render the question show page with errors
      redirect_to pulse_pulse_category_question_path(@question.pulse_category.pulse, @question.pulse_category, @question), status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
