# == Schema Information
#
# Table name: competency_level_has_courses
#
#  id                  :integer          not null, primary key
#  competency_level_id :integer
#  course_id           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe CompetencyLevelHasCourse do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { should validate_presence_of :course_id}
  it { should validate_presence_of :competency_level_id}
  it { should belong_to :competency_level}
  it { should belong_to :course}

  it "should has a valid competency_level_has_course factory" do
    FactoryGirl.create(:competency_level_has_course).should be_valid
  end

end
