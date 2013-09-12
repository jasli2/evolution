class AjaxController < ApplicationController
  def form
    # 
    # example:
    # /ajax/form/users/new
    # /ajax/form/users/edit/1
    #
    model_name = params[:model].to_s
    type = params[:type].to_s
    if type == 'new'
      instance_variable_set('@'+model_name.singularize, model_name.classify.constantize.new)
    elsif type == 'edit'
      instance_variable_set('@'+model_name.singularize, model_name.classify.constantize.find(params[:id]))
    else
      raise NameError
    end

    render :partial => model_name + '/form'
  end
end
