require 'spec_helper'

describe CompetencyLevel do
  it { should validate_presence_of :level }
  it { should validate_presence_of :description }
  it { should have_many :competency_level_requirements }
  it { should belong_to :competency }

  it "should has valid factory" do
    FactoryGirl.create(:competency_level).should be_valid
  end

  it "should has unique level" do
    c = FactoryGirl.create(:competency_level)
    FactoryGirl.build(:competency_level, :level => c.level).should_not be_valid
  end
end
