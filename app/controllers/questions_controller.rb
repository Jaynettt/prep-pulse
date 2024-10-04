class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    @question = Question.first

    # redirect_to question_path(@question)
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end
end
