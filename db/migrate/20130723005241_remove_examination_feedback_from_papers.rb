class RemoveExaminationFeedbackFromPapers < ActiveRecord::Migration
  def up
    remove_column :papers, :examination_feedback
  end

  def down
    add_column :papers, :examination_feedback, :integer
  end
end
