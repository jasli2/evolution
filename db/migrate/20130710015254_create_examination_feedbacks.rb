class CreateExaminationFeedbacks < ActiveRecord::Migration
  def change
    create_table :examination_feedbacks do |t|
      t.integer :examination_id
      t.integer :user_id

      t.timestamps
    end
  end
end
