class AddDurationSpentToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_column :answers, :duration_spent, :float
  end
end
