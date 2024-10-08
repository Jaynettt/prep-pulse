class AddStartTimeAndEndTimeToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_column :answers, :start_time, :datetime
    add_column :answers, :end_time, :datetime
  end
end
