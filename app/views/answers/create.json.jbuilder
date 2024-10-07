if @answer.persisted?
  json.form render_to_string(partial: "questions/show", formats: :html, locals: { answer: Answer.new, question: @next_question })
else
  json.form render_to_string(partial: "questions/show", formats: :html, locals: { answer: @answer, question: @question })
end
