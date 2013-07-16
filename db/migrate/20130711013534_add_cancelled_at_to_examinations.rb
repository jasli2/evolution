class AddCancelledAtToExaminations < ActiveRecord::Migration
  def change
    add_column :examinations, :cancelled_at, :datetime
  end
end
