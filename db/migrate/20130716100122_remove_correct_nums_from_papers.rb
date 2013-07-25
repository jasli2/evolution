class RemoveCorrectNumsFromPapers < ActiveRecord::Migration
  def up
    remove_column :papers, :correct_nums
  end

  def down
    add_column :papers, :correct_nums, :integer
  end
end
