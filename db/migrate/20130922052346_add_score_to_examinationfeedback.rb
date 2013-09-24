class AddScoreToExaminationfeedback < ActiveRecord::Migration
  def change
    add_column :examination_feedbacks, :score, :integer
  end
end
