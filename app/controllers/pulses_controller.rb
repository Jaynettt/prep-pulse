class PulsesController < ApplicationController
  def index
    @pulses = Pulse.all
  end

  def show
    @pulse = Pulse.find(params[:id])
    @categories = Category.all

    @categories = @pulse.categories.where(name: ['Soft skills', 'Technical skills', 'Psychometric skills'])

    # @answers = @pulse.answers

    # @category_evaluations = {}
    # @categories.each do |category|
    #   category_answers = @answers.select { |answer| answer.question.pulse_category.category_id == category.id }
    #   total_evaluation = category_answers.sum(&:evaluation)
    #   evaluation_count = category_answers.size
    #   @category_evaluations[category.id] = evaluation_count > 0 ? (total_evaluation.to_f / evaluation_count) : 0
  end

  def new
    @pulse = Pulse.new
  end

  def create
    @pulse = Pulse.new(pulse_params)
    @pulse.user = current_user
    if @pulse.save!
      redirect_to categories_path(@pulse)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pulse = Pulse.find(params[:id])
  end

  def update
    @pulse = Pulse.find(params[:id])
    @pulse.update(pulse_params)

    redirect_to pulse_path(@pulse)
  end

  def destroy
    @pulse = Pulse.find(params[:id])
    @pulse.destroy

    redirect_to pulses_path, status: :see_other
  end

  private

  def pulse_params
    params.require(:pulse).permit(:job_role, :company_name, :company_description)
  end
end
