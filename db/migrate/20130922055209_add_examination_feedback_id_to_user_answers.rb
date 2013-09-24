class AddExaminationFeedbackIdToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :examination_feedback_id, :integer
  end
end
