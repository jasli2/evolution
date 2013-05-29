class ChangeDescriptionFormatInCourses < ActiveRecord::Migration
  def change
    change_column :courses, :description, :text
    add_column :courses, :audience, :string
    add_column :courses, :target, :string
    add_column :courses, :teach_type, :string
    add_column :courses, :source_type, :string
    add_column :courses, :lesson, :string
    remove_column :courses, :author
    remove_column :courses, :filter_item 
  end
end
