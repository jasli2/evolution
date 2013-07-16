class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.integer :score
      t.integer :correct_nums
      t.integer :error_nums

      t.timestamps
    end
  end
end
