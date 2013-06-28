require 'spec_helper'

describe ClassUserRole do
  it { should belong_to :user }
  it { should belong_to :course_class }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :course_class_id }
end
