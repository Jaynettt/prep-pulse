class SetChatReviewJob < ApplicationJob
  queue_as :default

  def perform(answer)
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
    model: "gpt-4",  # Use the correct model
    messages: [{ role: "user", content: "Give some constructive feedback for this answer #{answer.content}. The interview question was #{answer.question.content}. Make it 500 characters maximum"}]
    })
    new_chat_review = chatgpt_response["choices"][0]["message"]["content"]



    response = client.chat(parameters: {
      model: "gpt-4",
      messages: [
        { role: "user", content: "Rate the following answer on a scale of 0 to 10: '#{answer.content}'. Give me only the number." }
      ]
    })

    new_evaluation = response["choices"][0]["message"]["content"].to_i

    answer.update(evaluation: new_evaluation, chat_review: new_chat_review) # Persist the new evaluation
    Turbo::StreamsChannel.broadcast_replace_to(
      "result_pulse_#{answer.question.pulse.id}",
      target: "result_pulse_#{answer.question.pulse.id}",
      partial: "pulses/results", locals: { pulse: answer.question.pulse})
  end
end
