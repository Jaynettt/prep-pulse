class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @categories = Category.all

    @progress_by_category = {}

    @categories.each do
  end
end
