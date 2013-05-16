# == Schema Information
#
# Table name: activity_has_users
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :integer
#  user_id     :integer
#

require 'spec_helper'

describe ActivityHasUser do
  #pending "add some examples to (or delete) #{__FILE__}"
  it {should validate_presence_of :activity_id}
  it {should validate_presence_of :user_id}
  it {should belong_to :user}
  it {should belong_to :activity}

  it "should has valid activity_has_user factory" do
    FactoryGirl.create(:activity_has_user).should be_valid
  end

end
