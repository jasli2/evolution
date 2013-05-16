# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  author      :string(255)
#  filter_item :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Course do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { should validate_presence_of :title }
  it { should validate_presence_of :author }
  it { should validate_presence_of :filter_item }
  it { should have_many :activity_has_courses }
  it { should have_many :activities }
  it { should have_many :position_has_courses }
  it { should have_many :positions }
  it { should have_many :competency_level_has_courses }
  it { should have_many :competency_levels }
  it { should have_many :user_course_progresses }
  it { should have_many :users }

  it "should has valid course factory" do
    FactoryGirl.create(:course).should be_valid
  end
end
