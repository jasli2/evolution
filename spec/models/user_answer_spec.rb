# == Schema Information
#
# Table name: user_answers
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#  paper_id    :integer
#

require 'spec_helper'

describe UserAnswer do
  pending "add some examples to (or delete) #{__FILE__}"
end
