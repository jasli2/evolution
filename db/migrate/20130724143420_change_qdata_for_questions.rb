class ChangeQdataForQuestions < ActiveRecord::Migration
  def up
    change_column :questions, :qdata, :string
  end

  def down
    change_column :questions, :qdata, :text
  end
end
