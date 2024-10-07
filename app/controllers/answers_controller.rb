class AnswersController < ApplicationController
  def index
    @answer = Answer.all
  end

  def create
    @question = Question.find(params[:question_id])
    @pulse = @question.pulse_category.pulse
    @answer = Answer.new(answer_params)
    @answer.question = @question

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
    params.require(:answer).permit(:content)
  end
end
