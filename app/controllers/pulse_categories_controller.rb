class PulseCategoriesController < ApplicationController

  def show
    @pulse = Pulse.find(params[:pulse_id])
    @pulse_category = PulseCategory.find(params[:id])
    @questions = @pulse_category.questions
  end
end
