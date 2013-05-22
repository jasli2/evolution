class AddNameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :name, :string
    User.all.each do |u|
      u.update_attribute :name, u.first_name + ' ' + u.last_name
    end
    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def down
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    User.all.each do |u|
      u.update_attribute :first_name, u.name.match(/\w+/)[0]
      u.update_attribute :last_name, u.name.match(/\w+/)[1]
    end
    remove_column :users, :name
  end
end
