# == Schema Information
#
# Table name: course_classes
#
#  id             :integer          not null, primary key
#  course_id      :integer
#  state          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  creator_id     :integer
#  teach_date     :datetime
#  eroll_deadline :datetime
#  max_students   :integer
#  start_time     :datetime
#  end_time       :datetime
#  address        :string(255)
#

require 'spec_helper'

describe CourseClass do
  it { should validate_presence_of :course_id }
  it { should belong_to :course }
  it { should have_many :students }
  it { should have_many :teachers }
  it { should have_many :assistents }

end
