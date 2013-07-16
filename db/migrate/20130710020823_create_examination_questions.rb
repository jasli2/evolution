class CreateExaminationQuestions < ActiveRecord::Migration
  def change
    create_table :examination_questions do |t|
      t.integer :examination_id
      t.integer :question_id

      t.timestamps
    end
  end
end
