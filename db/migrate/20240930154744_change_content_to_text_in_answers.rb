class ChangeContentToTextInAnswers < ActiveRecord::Migration[7.2]
  def change
    change_column :answers, :content, :text
  end
end
