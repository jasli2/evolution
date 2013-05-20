# == Schema Information
#
# Table name: activity_has_courses
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :integer
#  activity_id :integer
#

require 'spec_helper'

describe ActivityHasCourse do
  #pending "add some examples to (or delete) #{__FILE__}"
  it {should validate_presence_of :course_id}
  it {should validate_presence_of :activity_id}
  it {should belong_to :course}
  it {should belong_to :activity}

  it "should has valid activity_has_course factory" do
    FactoryGirl.create(:activity_has_course).should be_valid
  end
end
