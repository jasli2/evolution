# == Schema Information
#
# Table name: training_plan_feedbacks
#
#  id               :integer          not null, primary key
#  training_plan_id :integer
#  user_id          :integer
#  note             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe TrainingPlanFeedback do
  it { should validate_presence_of :training_plan_id }
  it { should validate_presence_of :user_id }
  it { should belong_to :user }
  it { should belong_to :training_plan }
  it { should have_many :courses }
end
