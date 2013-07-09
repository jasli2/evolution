class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :description
      t.integer :attachable_id
      t.string :attachable_type
      t.string :file

      t.timestamps
    end
  end
end
