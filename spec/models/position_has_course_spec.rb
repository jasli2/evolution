# == Schema Information
#
# Table name: position_has_courses
#
#  id          :integer          not null, primary key
#  position_id :integer
#  course_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe PositionHasCourse do
 # pending "add some examples to (or delete) #{__FILE__}"
  it {should validate_presence_of :course_id}
  it {should validate_presence_of :position_id}
  it {should belong_to :course}
  it {should belong_to :position}

  it "should has valid course factory" do
    FactoryGirl.create(:position_has_course).should be_valid
  end
end
