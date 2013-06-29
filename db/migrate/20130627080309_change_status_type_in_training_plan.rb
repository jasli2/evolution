class ChangeStatusTypeInTrainingPlan < ActiveRecord::Migration
  def up
    change_column :training_plans, :status, :string
    add_column :training_plans, :finished_at, :datetime
    add_column :training_plans, :cancelled_at, :datetime
  end

  def down
    change_column :training_plans, :status, :integer
    remove_column :training_plans, :finished_at, :datetime
    remove_column :training_plans, :cancelled_at, :datetime
  end
end
