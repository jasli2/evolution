class ContractsController < ApplicationController
  def index
    @menu_category = current_user.is_admin? ? 'admin' : 'user'
    @menu_active = 'contract'

    @contracts = current_user.is_admin? ? Contract.all : Contract.find_by_user_name(current_user.name)

    respond_to do |format|
      format.html 
    end
  end

  def show
    @menu_category = current_user.is_admin? ? 'admin' : 'user'
    @menu_active = 'contract'

    @contract = Contract.find(params[:id]) if params[:id]

    respond_to do |format|
      format.html 
    end
  end
end
