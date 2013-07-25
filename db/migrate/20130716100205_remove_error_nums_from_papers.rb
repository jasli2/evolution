class RemoveErrorNumsFromPapers < ActiveRecord::Migration
  def up
    remove_column :papers, :error_nums
  end

  def down
    add_column :papers, :error_nums, :integer
  end
end
