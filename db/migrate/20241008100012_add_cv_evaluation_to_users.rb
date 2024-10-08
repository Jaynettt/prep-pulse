class AddCvEvaluationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :cv_evaluation, :text
  end
end
