class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end

  def dashboard
    @pulses = Pulse.where(user: current_user)
  end
end
