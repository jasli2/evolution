class CreateCompetencyUsers < ActiveRecord::Migration
  def change
    create_table :competency_users do |t|
      t.integer :self_eval_level
      t.integer :mgr_eval_level
      t.integer :user_id
      t.integer :competency_id

      t.timestamps
    end
  end
end
