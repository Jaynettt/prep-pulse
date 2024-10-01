class AnswersController < ApplicationController

  def show
    @answer = Answer.all
  end
end
