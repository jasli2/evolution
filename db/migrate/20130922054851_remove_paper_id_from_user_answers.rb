class RemovePaperIdFromUserAnswers < ActiveRecord::Migration
  def up
    remove_column :user_answers, :paper_id
  end

  def down
    add_column :user_answers, :paper_id, :integer
  end
end
