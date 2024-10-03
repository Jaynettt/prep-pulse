class AnswersController < ApplicationController

  def index
    @anwer =  Answer.all
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    # @answer.user = current_user
    if @answer.save
      @next_question = Question.find(@question.id + 1)
      redirect_to question_path(@next_question)
    else
      redirect_to question_path(@question), status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
