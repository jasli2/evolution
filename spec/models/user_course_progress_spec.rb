# == Schema Information
#
# Table name: user_course_progresses
#
#  id              :integer          not null, primary key
#  course_id       :integer
#  user_id         :integer
#  course_progress :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe UserCourseProgress do
  #pending "add some examples to (or delete) #{__FILE__}"
  it {should validate_presence_of :course_id}
  it {should validate_presence_of :user_id}
  it {should validate_presence_of :course_progress}
  it {should belong_to :user}
  it {should belong_to :course}

  it 'should have unique name' do
    FactoryGirl.create(:user_course_progress).should be_valid
  end

end
