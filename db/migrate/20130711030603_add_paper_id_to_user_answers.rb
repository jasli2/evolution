class AddPaperIdToUserAnswers < ActiveRecord::Migration
  def change
    add_column :user_answers, :paper_id, :integer
  end
end
