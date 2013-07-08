class CreateUserClassProgresses < ActiveRecord::Migration
  def change
    create_table :user_class_progresses do |t|
      t.integer :user_id
      t.integer :course_class_id
      t.integer :training_plan_id
      t.string :progress

      t.timestamps
    end
  end
end
