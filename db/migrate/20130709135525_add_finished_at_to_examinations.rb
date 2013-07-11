class AddFinishedAtToExaminations < ActiveRecord::Migration
  def change
    add_column :examinations, :finished_at, :datetime
  end
end
