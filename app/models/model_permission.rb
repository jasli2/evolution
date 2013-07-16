# == Schema Information
#
# Table name: model_permissions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  model_name :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ModelPermission < ActiveRecord::Base

  attr_accessible :user_id, :model_name	

  belongs_to :user
  has_many :action_permissions

  validates :user_id, :presence => true
  validates :model_name, :presence => true

  def action_permit(action)
  	@permit = self.action_permissions.find_by_action_name(action) 
  	if @permit == nil
  		return nil
  	else
  		return @permit.user_scope
  	end		  	
  end

end
