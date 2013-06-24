class CreateTrainingPlans < ActiveRecord::Migration
  def change
    create_table :training_plans do |t|
      t.string    :title
      t.date      :feedback_deadline
      t.date      :end_day
      t.integer   :required_course_min, :default => 0
      t.integer   :required_course_max, :default => 0
      t.integer   :optional_course_min, :default => 0
      t.integer   :optional_course_max, :default => 0
      t.integer   :status

      t.timestamps
    end
  end
end
