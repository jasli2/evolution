class ChangeStatusToStateInTrainingPlan < ActiveRecord::Migration
  def change
    rename_column :training_plans, :status, :state
  end
end
