class PulsesController < ApplicationController
  def index
    @pulses = Pulse.all
  end
  
  def show
    @pulse = Pulse.find(params[:id])
  end

  def new
    @pulse = Pulse.new
  end

  def create
    @pulse = Pulse.new(pulse_params)
    @pulse.user = current_user
    if @pulse.save!
      redirect_to pulse_path(@pulse)
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
