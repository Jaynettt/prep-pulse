class RemoveDurationTakenFromAnswers < ActiveRecord::Migration[7.2]
  def change
    remove_column :answers, :duration_taken, :integer
  end
end
