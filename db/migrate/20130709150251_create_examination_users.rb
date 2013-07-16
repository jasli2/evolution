class CreateExaminationUsers < ActiveRecord::Migration
  def change
    create_table :examination_users do |t|
      t.integer :examination_id
      t.integer :user_id

      t.timestamps
    end
  end
end
