class AddPublishedAtToExaminations < ActiveRecord::Migration
  def change
    add_column :examinations, :published_at, :datetime
  end
end
