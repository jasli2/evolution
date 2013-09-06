class RenameQdataFromQuestions < ActiveRecord::Migration
  def up
    rename_column :questions, :qdata, :title
  end

  def down
  end
end
