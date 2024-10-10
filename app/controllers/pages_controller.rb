class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end

  def dashboard
    @pulses = Pulse.where(user: current_user)
    @category_averages = current_user.average_evaluation_by_category

  end

  
  def overview
    @category_averages = current_user.average_evaluation_by_category

  end
end
