class CreateCompetencyLevels < ActiveRecord::Migration
  def change
    create_table :competency_levels do |t|
      t.integer   :level, :limit => 1
      t.string    :description 
      t.integer   :competency_id

      t.timestamps
    end
  end
end
