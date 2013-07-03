class AddUserIdToTrainingPlan < ActiveRecord::Migration
  def change
    add_column :training_plans, :creator_id, :integer
  end
end
