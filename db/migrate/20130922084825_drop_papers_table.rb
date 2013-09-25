class DropPapersTable < ActiveRecord::Migration
  def up
    drop_table :papers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
