# == Schema Information
#
# Table name: training_feedback_courses
#
#  id                        :integer          not null, primary key
#  training_plan_feedback_id :integer
#  course_id                 :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

require 'spec_helper'

describe TrainingFeedbackCourse do
  pending "add some examples to (or delete) #{__FILE__}"
end
