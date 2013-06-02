class AddExaminationIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :examination_id, :integer
  end
end
