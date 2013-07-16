class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.string :content
      t.boolean :correct

      t.timestamps
    end
  end
end
