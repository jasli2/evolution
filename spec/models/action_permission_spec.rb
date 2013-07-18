# == Schema Information
#
# Table name: action_permissions
#
#  id                  :integer          not null, primary key
#  model_permission_id :integer
#  action_name         :string(255)
#  user_scope          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe ActionPermission do
  pending "add some examples to (or delete) #{__FILE__}"
end
