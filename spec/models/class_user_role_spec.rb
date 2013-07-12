# == Schema Information
#
# Table name: class_user_roles
#
#  id              :integer          not null, primary key
#  course_class_id :integer
#  user_id         :integer
#  role            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe ClassUserRole do
  it { should belong_to :user }
  it { should belong_to :course_class }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :course_class_id }
end
