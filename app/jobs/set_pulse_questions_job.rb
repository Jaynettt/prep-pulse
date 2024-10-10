class SetPulseQuestionsJob < ApplicationJob
  queue_as :default

  def perform(pulse)
    pulse.pulse_categories.each do |pulse_category|
      1.times do
        Question.create!(pulse_category: pulse_category)
      end
    end


    Turbo::StreamsChannel.broadcast_update_to(
      "pulse_#{pulse.id}",
      target: "pulse_#{pulse.id}",
      partial: "pulses/ready", locals: { pulse: pulse })

  end
end
