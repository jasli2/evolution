class AddCorrectToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :correct, :boolean
  end
end
