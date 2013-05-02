class CreateCompetencyLevelRequirements < ActiveRecord::Migration
  def change
    create_table :competency_level_requirements do |t|
      t.string    :description
      t.integer   :competency_level_id

      t.timestamps
    end
  end
end
