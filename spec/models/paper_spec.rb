# == Schema Information
#
# Table name: papers
#
#  id             :integer          not null, primary key
#  score          :integer
#  correct_nums   :integer
#  error_nums     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  examination_id :integer
#

require 'spec_helper'

describe Paper do
  pending "add some examples to (or delete) #{__FILE__}"
end
