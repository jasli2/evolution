require 'spec_helper'

describe TrainingPlanCourse do
  it { should validate_presence_of :training_plan_id }
  it { should validate_presence_of :course_id }
  it { should belong_to :course }
  it { should belong_to :training_plan }

  it "should has valid factory" do
    FactoryGirl.create(:training_plan_course).should be_valid
  end

  it "should not valid if couse_type_str set to unknown" do
    t = FactoryGirl.build(:training_plan_course)
    t.course_type_str = "unknown"
    t.should_not be_valid
  end
end
