# == Schema Information
#
# Table name: training_plan_users
#
#  id               :integer          not null, primary key
#  training_plan_id :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe TrainingPlanUser do
  it { should validate_presence_of :training_plan_id }
  it { should validate_presence_of :user_id }
  it { should belong_to :training_plan }
  it { should belong_to :user }
end
