class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    @question = Question.first

    # redirect_to question_path(@question)
  end


  def show
    @question = Question.find(params[:id])

    if @question.nil?
      redirect_to questions_path, alert: "Question not found."
    else
      @answer= Answer.new
    end

  end
end
