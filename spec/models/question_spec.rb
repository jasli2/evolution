# == Schema Information
#
# Table name: questions
#
#  id             :integer          not null, primary key
#  qdata          :text
#  answer         :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  examination_id :integer
#

require 'spec_helper'

describe Question do
  pending "add some examples to (or delete) #{__FILE__}"
end
