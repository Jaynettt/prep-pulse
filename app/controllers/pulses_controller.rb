class PulsesController < ApplicationController
  def index
    @pulses = Pulse.all
  end

  def show
    @pulse = Pulse.find(params[:id])


    @categories = @pulse.categories.where(name: ['Soft skills', 'Technical skills', 'Psychometric skills'])
  end

  def new
    @pulse = Pulse.new
  end

  def create
    @pulse = Pulse.new(pulse_params)
    @pulse.user = current_user
    if @pulse.save
      first_question = @pulse.questions.order(:id).first
      if first_question
        redirect_to pulse_question_path(@pulse, first_question)
      else
        redirect_to pulses_path, notice: "No questions found for this Pulse."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pulse = Pulse.find(params[:id])
  end

  def update
    @pulse = Pulse.find(params[:id])

    if @pulse.update(pulse_params)
      # Find the first category from the updated pulse
      first_category = @pulse.categories.first

      if first_category
        # Retrieve the first question for the selected category
        first_question = first_category.questions.order(:id).first
        if first_question
          redirect_to pulse_question_path(@pulse, first_question), notice: 'Pulse updated successfully.'
        else
          redirect_to pulses_path, notice: "Pulse updated, but no questions found for the selected category."
        end
      else
        redirect_to pulses_path, notice: "Pulse updated, but no categories found."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pulse = Pulse.find(params[:id])
    @pulse.destroy

    redirect_to pulses_path, status: :see_other
  end

  private

  def pulse_params
    params.require(:pulse).permit(:job_role, :company_name, :company_description, category_ids: [])
  end
end
