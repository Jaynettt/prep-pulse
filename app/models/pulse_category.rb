class PulseCategory < ApplicationRecord
  belongs_to :pulse
  has_many :questions
  belongs_to :category

  def average_rating
    answer_rating = 0
    questions.each do |question|
      answer_rating += question.average_answer_rating
    end
    return answer_rating.fdiv(questions.count)
  end
end
