class AddStateToExaminations < ActiveRecord::Migration
  def change
    add_column :examinations, :state, :string
  end
end
