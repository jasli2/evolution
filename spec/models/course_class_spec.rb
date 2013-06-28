require 'spec_helper'

describe CourseClass do
  it { should validate_presence_of :course_id }
  it { should belong_to :course }
  it { should have_many :students }
  it { should have_many :teachers }
  it { should have_many :assistents }

end
