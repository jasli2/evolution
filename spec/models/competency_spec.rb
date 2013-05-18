# == Schema Information
#
# Table name: competencies
#
#  id          :integer          not null, primary key
#  name        :string(40)
#  description :string(255)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Competency do
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should have_many :competency_levels }
  it {should have_many :competency_users}
  it {should have_many :users}


  it "should has valid factory" do
    FactoryGirl.create(:competency).should be_valid
  end

  it "should has unique name" do
    c = FactoryGirl.create(:competency)
    FactoryGirl.build(:competency, :name => c.name).should_not be_valid
  end
end
