class SetChatReviewJob < ApplicationJob
  queue_as :default

  def perform(answer)
    # Use Rails.cache to check for cached review and evaluation
    cached_review = Rails.cache.fetch("chat_review_#{answer.id}")
    cached_evaluation = Rails.cache.fetch("evaluation_#{answer.id}")

    if cached_review && cached_evaluation
      update_answer(answer, cached_evaluation, cached_review)
    else
      # Debounce logic: ensure that subsequent requests wait
      Rails.cache.fetch("debounce_broadcast_#{answer.id}", expires_in: 5.seconds) do
        client = OpenAI::Client.new

        # Construct requests only if not cached
        chatgpt_response = client.chat(parameters: {
          model: "gpt-4",
          messages: [{ role: "user", content: "Give some constructive feedback for this answer #{answer.content}. The interview question was #{answer.question.content}. Make it 500 characters maximum"}]
        })

        new_chat_review = chatgpt_response["choices"][0]["message"]["content"]
        Rails.cache.write("chat_review_#{answer.id}", new_chat_review)

        evaluation_response = client.chat(parameters: {
          model: "gpt-4",
          messages: [
            { role: "user", content: "Rate the following answer on a scale of 1 to 10: '#{answer.content}'. Give me only the number." }
          ]
        })

        new_evaluation = evaluation_response["choices"][0]["message"]["content"].to_i
        Rails.cache.write("evaluation_#{answer.id}", new_evaluation)

        update_answer(answer, new_evaluation, new_chat_review)
      end
    end
  end

  private

  def update_answer(answer, evaluation, chat_review)
    answer.update!(evaluation: evaluation, chat_review: chat_review)
    Turbo::StreamsChannel.broadcast_update_to(
      "result_pulse_#{answer.question.pulse.id}",
      target: "result_pulse_#{answer.question.pulse.id}",
      partial: "pulses/results", locals: { pulse: answer.question.pulse }
    )
  end
end
