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

require 'spec_helper'

describe ModelPermission do
  pending "add some examples to (or delete) #{__FILE__}"
end
