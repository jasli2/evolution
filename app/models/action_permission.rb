# == Schema Information
#
# Table name: action_permissions
#
#  id         				:integer          not null, primary key
#  model_permission_id    	:integer
#  action_name			    :string(255)
#  user_scope				:integer
#  created_at 				:datetime         not null
#  updated_at 				:datetime         not null
#

class ActionPermission < ActiveRecord::Base

	attr_accessible :model_permission_id, :action_name, :user_scope

  	belongs_to :model_permission

end
