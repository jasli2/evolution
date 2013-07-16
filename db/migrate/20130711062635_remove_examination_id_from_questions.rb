class RemoveExaminationIdFromQuestions < ActiveRecord::Migration
  def up
    remove_column :questions, :examination_id
  end

  def down
    add_column :questions, :examination_id, :integer
  end
end
