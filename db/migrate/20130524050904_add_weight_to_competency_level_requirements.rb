class AddWeightToCompetencyLevelRequirements < ActiveRecord::Migration
  def change
    add_column :competency_level_requirements, :weight, :integer
  end
end
