class CreateExaminations < ActiveRecord::Migration
  def change
    create_table :examinations do |t|
      t.string :title
      t.integer :creator_id

      t.timestamps
    end
  end
end
