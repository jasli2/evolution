class CreateActivityHasCourses < ActiveRecord::Migration
  def change
    create_table :activity_has_courses do |t|

      t.timestamps
    end
  end
end
