class AddSelfIntroToUsers < ActiveRecord::Migration
  def change
    add_column :users, :self_intro, :string
    add_column :users, :teacher_rate, :integer
  end
end
