# == Schema Information
#
# Table name: discusses
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  course_class_id :integer
#  title           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Discuss do
  pending "add some examples to (or delete) #{__FILE__}"
end
