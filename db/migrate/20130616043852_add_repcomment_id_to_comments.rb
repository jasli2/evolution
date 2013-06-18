class AddRepcommentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :repcomment_id, :integer
  end
end
