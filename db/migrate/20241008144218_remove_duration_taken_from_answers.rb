class RemoveDurationTakenFromAnswers < ActiveRecord::Migration[7.2]
  def change
    remove_column :answers, :duration_spent, :integer
  end
end
