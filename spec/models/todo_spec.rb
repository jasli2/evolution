# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  source_type :string(255)
#  source_id   :integer
#  finish_at   :datetime
#  deadline    :datetime
#  todo_type   :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Todo do
  it { should validate_presence_of :source }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :deadline }
  it { should validate_presence_of :todo_type }
  it { should belong_to :user }
  it { should belong_to :source }

end
