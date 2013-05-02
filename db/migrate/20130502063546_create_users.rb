class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :first_name, :limit => 24, :null => false
      t.string      :last_name, :limit => 24, :null => false
      t.string      :email, :limit => 128, :null => false
      t.integer     :manager_id
      t.date        :birthday
      t.date        :joined_at

      t.timestamps
    end
  end
end
