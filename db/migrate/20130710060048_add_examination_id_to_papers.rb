class AddExaminationIdToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :examination_id, :integer
  end
end
