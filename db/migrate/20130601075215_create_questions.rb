class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :qdata
      t.string :answer

      t.timestamps
    end
  end
end
