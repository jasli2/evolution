authorization do
	role :admin do
		has_permission_on :admin_admin, :to => [:dashboard, :user, :position, :competency, :course]
		includes :user_manager
		includes :competency_senior_manager
	end

#User Module
#user_controller : dashboard, index, show, new, edit, create, update, destroy, import, export
# 				   mgr_assessments, assessment, update_assessment, notifications, update_notifications
#position_controller : CRUD, import, export
	role :user_guest do
	end
	role :user_user do
		has_permission_on :users, :to => [:dashboard, :read, :update] do
			if_attribute :id => is { user.id }
		end
		has_permission_on :users, :to => [:notifications, :update_notifications]
		has_permission_on :positions, :to => :read
	end
	role :user_manager do
		includes :user_user
		has_permission_on :users, :to => :update do
			if_attribute :id => is_not { user.id }
		end
		has_permission_on :user, :to => [:delete, :update] do
			if_attribute :department => is { user.department }
		end
	end
	role :user_admin do
		includes :user_manager
		has_permission_on :users, :to => :delete do
			if_attribute :id => is_not { user.id }
		end
		has_permission_on :users, :to => [:create, :import, :export]
		has_permission_on :positions, :to => [:create, :update, :delete, :import, :export]
	end

#competency
	role :competency_guest do
	end
	role :competency_user do
		has_permission_on :users, :to => [:mgr_assessments, :assessment, :update_assessment] do
			if_attribute :id => is { user.id }
		end
		has_permission_on :competencies, :to => :read
		has_permission_on :competency_levels, :to => :read
		has_permission_on :competency_level_requirements, :to => :read
		has_permission_on :competency_users, :to => :read
	end
	role :competency_manager do
		includes :competency_user
		has_permission_on :users, :to => [:mgr_assessments, :assessment, :update_assessment] do
			if_attribute :manager_id => is { user.id }
		end
	end
	role :competency_senior_manager do
		includes :competency_manager
		has_permission_on :users, :to => [:mgr_assessments, :assessment, :update_assessment] do
			if_attribute :department => is { user.department }
		end
	end
	role :competency_admin do
		includes :competency_senior_manager
		has_permission_on :users, :to => [:mgr_assessments, :assessment, :update_assessment]
		has_permission_on :competencies, :to => [:manage, :import, :export]
		has_permission_on :competency_levels, :to => :manage
		has_permission_on :competency_level_requirements, :to => :manage
		has_permission_on :competency_users, :to => :manage
	end

#course
	role :course_guest do
	end
	role :course_user do
		has_permission_on :courses, :to => [:read]
		has_permission_on :class_user_roles, :to => [:update] do
			if_attribute :role => is {'student'}
		end
	end
	role :course_manager do
		includes :course_user
	end
	role :course_teacher do
		includes :course_user
	end
	role :course_admin do
		includes :course_manager
		has_permission_on :courses, :to => [:create, :update, :delete]
	end

#training_plan
	role :plan_guest do
	end
	role :plan_admin do
		has_permission_on :training_plans, :to => [:create, :update, :delete]
	end

#permission
	role :permission_guest do
	end
	role :permission_user do
	end
	role :permission_manager do
	end
	role :permission_admin do
	end

#examination
	role :examination_guest do
	end
	role :examination_user do
	end
	role :examination_teacher do
	end
	role :examination_admin do
	end

#knowledge
	role :knowledge_guest do
	end
	role :knowledge_user do
	end
	role :knowledge_admin do
	end

#report
	role :report_guest do
	end
	role :report_admin do
	end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
