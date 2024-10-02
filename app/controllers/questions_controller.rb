class QuestionsController < ApplicationController

  def index
    @questions = Question.all

  def show
    @question = Question.find(params[:id])
    @answer= Answer.new
  end

end
