class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new # guest user (not logged in) 
    if user.admin?
        can :manage, User
    else
        if authority(user, User, 'Update') > 0
            can :update, User
        else
            cannot :update, User
        end        
    end     
  end 
  
  def authority(user, model, action)
    @model = user.model_permissions.find_by_model_name(model)
    if @model == nil
        return nil
    else    
        @scope = @model.action_permissions.find_by_action_name(action)
        if @scope == nil
            return nil 
        else
            return @scope.user_scope
        end
    end             
  end 
end
