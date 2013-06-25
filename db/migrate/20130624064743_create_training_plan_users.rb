class CreateTrainingPlanUsers < ActiveRecord::Migration
  def change
    create_table :training_plan_users do |t|
      t.integer :training_plan_id
      t.integer :user_id

      t.timestamps
    end
  end
end
