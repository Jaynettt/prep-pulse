class AddChatReviewToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_column :answers, :chat_review, :text
  end
end
