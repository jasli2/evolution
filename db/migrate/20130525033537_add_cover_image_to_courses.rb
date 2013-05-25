class AddCoverImageToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :cover_image, :string
  end
end
