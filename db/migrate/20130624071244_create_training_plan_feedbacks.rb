class CreateTrainingPlanFeedbacks < ActiveRecord::Migration
  def change
    create_table :training_plan_feedbacks do |t|
      t.integer :training_plan_id
      t.integer :user_id
      t.string  :note

      t.timestamps
    end
  end
end
