# == Schema Information
#
# Table name: model_permissions
#
#  id         		:integer          not null, primary key
#  role    	  		:string(255)
#  model_name 		:string(255)
#  create_permit	:integer
#  edit_permit		:integer
#  read_permit		:integer
#  created_at 		:datetime         not null
#  updated_at 		:datetime         not null
#
#encoding:utf-8
class DefaultPermission < ActiveRecord::Base
  attr_accessible :create_permit, :edit_permit, :model_name, :read_permit, :role

  def get_permit_scope(scope)
  	if scope == 0
  		return I18n.t("permission scope null")
  	end
  	if scope == 1
  		return I18n.t("permission scope self")
  	end	
  	if scope == 2
  		return I18n.t("permission scope department")
  	end	
  	if scope == 3
  		return I18n.t("permission scope global")
  	end
  end	

  def get_role_name(role)
  	if role == "Admin"
  		return I18n.t("permission role admin")
  	end
  	if role == "Manager"
  		return I18n.t("permission role manager")
  	end
  	if role == "Teacher"
  		return I18n.t("permission role teacher")
  	end
  	if role == "Staff"
  		return I18n.t("permission role staff")
  	end			
  end

  def get_model_name(model)
  	if model == "User"
  		return I18n.t("permission model user")
  	end
  	if model == "Permission"
  		return I18n.t("permission model permission")
  	end
  	if model == "Ability"
  		return I18n.t("permission model ability")
  	end
  	if model == "Teacher"
  		return I18n.t("permission model teacher")
  	end
  	if model == "Course"
  		return I18n.t("permission model course")
  	end
  	if model == "Plan"
  		return I18n.t("permission model plan")
  	end
  	if model == "Knowledge"
  		return I18n.t("permission model knowledge")
  	end
  end  
end
