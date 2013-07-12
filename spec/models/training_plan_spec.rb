# == Schema Information
#
# Table name: training_plans
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  feedback_deadline   :date
#  end_day             :date
#  required_course_min :integer          default(0)
#  required_course_max :integer          default(0)
#  optional_course_min :integer          default(0)
#  optional_course_max :integer          default(0)
#  state               :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  finished_at         :datetime
#  cancelled_at        :datetime
#  creator_id          :integer
#

require 'spec_helper'

describe TrainingPlan do
  it { should validate_presence_of :title }
  it { should validate_presence_of :feedback_deadline }
  it { should have_many :users }
  it { should have_many :courses }
  it { should have_many :feedbacks }
end
