class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name, :limit => 40
      t.string :description

      t.timestamps
    end
  end
end
