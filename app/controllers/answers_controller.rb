class AnswersController < ApplicationController

<<<<<<< HEAD
  def index
    @anwer =  Answer.all
  end

  def create
    @question = Question.find(params[:id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    @next_question = Question.find(params[:id]+ 1)
    @answer.user = current_user
    if @answer.save!
      redirect_to question_path(@next_question)
    else
      redirect_to question_path(@question), status: :unprocessable_entity
      #and the what? after an answer has been typesin we want to move to the next page unless its the last one then submit
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
=======
  def show
    @answer = Answer.all
  end
>>>>>>> master
end
