class AddEvaluationToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_column :answers, :evaluation, :integer
  end
end
