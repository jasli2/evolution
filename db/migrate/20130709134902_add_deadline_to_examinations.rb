class AddDeadlineToExaminations < ActiveRecord::Migration
  def change
    add_column :examinations, :deadline, :datetime
  end
end
