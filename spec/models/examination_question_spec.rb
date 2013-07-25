# == Schema Information
#
# Table name: examination_questions
#
#  id             :integer          not null, primary key
#  examination_id :integer
#  question_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe ExaminationQuestion do
  pending "add some examples to (or delete) #{__FILE__}"
end
