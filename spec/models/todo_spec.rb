require 'spec_helper'

describe Todo do
  it { should validate_presence_of :source }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :deadline }
  it { should validate_presence_of :todo_type }
  it { should belong_to :user }
  it { should belong_to :source }

end
