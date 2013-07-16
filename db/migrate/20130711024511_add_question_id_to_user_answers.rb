class AddQuestionIdToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :question_id, :integer
  end
end
