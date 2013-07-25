class AddExaminationFeedbackIdToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :examination_feedback_id, :integer
  end
end
