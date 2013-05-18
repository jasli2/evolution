# == Schema Information
#
# Table name: competency_levels
#
#  id            :integer          not null, primary key
#  level         :integer
#  description   :string(255)
#  competency_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe CompetencyLevel do
  it { should validate_presence_of :level }
  it { should validate_presence_of :description }
  it { should have_many :competency_level_requirements }
  it { should have_many :positions }
  it { should belong_to :competency }
  it {should have_many :competency_level_has_courses}
  it {should have_many :courses}

  it "should has valid factory" do
    FactoryGirl.create(:competency_level).should be_valid
  end

  it "should has unique level" do
    c = FactoryGirl.create(:competency_level)
    FactoryGirl.build(:competency_level, :level => c.level).should_not be_valid
  end
end
