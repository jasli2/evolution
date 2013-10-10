#  create_table "permission_roles", :force => true do |t|
#    t.integer  "user_id"
#    t.string   "role"
#    t.string	"module_name"
#    t.datetime "created_at", :null => false
#    t.datetime "updated_at", :null => false
#  end

class PermissionRole < ActiveRecord::Base
  using_access_control
  attr_accessible :role, :user_id, :module_name
  belongs_to :user
end
