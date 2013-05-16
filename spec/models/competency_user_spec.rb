# == Schema Information
#
# Table name: competency_users
#
#  id              :integer          not null, primary key
#  self_eval_level :integer
#  mgr_eval_level  :integer
#  user_id         :integer
#  competency_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe CompetencyUser do
  #pending "add some examples to (or delete) #{__FILE__}"

  it { should validate_presence_of :self_eval_level }
  it { should validate_presence_of :mgr_eval_level }
  it { should validate_presence_of :competency_id }
  it { should validate_presence_of :user_id }
  it { should belong_to :competency}
  it { should belong_to :user}

  it "should has valid course factory" do
    FactoryGirl.create(:competency_user).should be_valid
  end
end
