# == Schema Information
#
# Table name: examinations
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Examination do
  pending "add some examples to (or delete) #{__FILE__}"
end
