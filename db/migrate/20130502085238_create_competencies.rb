class CreateCompetencies < ActiveRecord::Migration
  def change
    create_table :competencies do |t|
      t.string    :name, :limit => 40
      t.string    :description
      t.integer   :category_id, :limit => 2

      t.timestamps
    end
  end
end
