class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    # @category = Category.find(params[:id])
    # if @question
    #   puts "Redirecting to question with id: #{@question.id}"
    #   # redirect_to question_path(@question)
    # else
    #   puts "No question found for category: #{@category.name}"
    #   redirect_to categories_path, alert: 'No questions available for this category.'
    # end
  end

  def show
    @question = Question.first
    redirect_to question_path(@question)
  end
end
