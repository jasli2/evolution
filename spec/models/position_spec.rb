# == Schema Information
#
# Table name: positions
#
#  id          :integer          not null, primary key
#  name        :string(40)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Position do
  it { should have_many :competency_levels }
  it { should have_many :users }
  it { should validate_presence_of :name }

  it 'should have unique name' do
    p = FactoryGirl.create(:position)
    FactoryGirl.build(:position, :name => p.name).should_not be_valid
  end
end
