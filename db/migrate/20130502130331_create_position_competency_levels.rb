class CreatePositionCompetencyLevels < ActiveRecord::Migration
  def change
    create_table :position_competency_levels do |t|
      t.integer :standard
      t.integer :position_id
      t.integer :competency_level_id

      t.timestamps
    end
  end
end
