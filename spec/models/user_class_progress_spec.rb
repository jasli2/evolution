# == Schema Information
#
# Table name: user_class_progresses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  course_class_id  :integer
#  training_plan_id :integer
#  progress         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe UserClassProgress do
  pending "add some examples to (or delete) #{__FILE__}"
end
