# == Schema Information
#
# Table name: position_competency_levels
#
#  id                  :integer          not null, primary key
#  standard            :integer
#  position_id         :integer
#  competency_level_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe PositionCompetencyLevel do
  it { should validate_presence_of :position_id }
  it { should validate_presence_of :competency_level_id }
  it { should validate_presence_of :standard }
  it { should belong_to :competency_level }
  it { should belong_to :position }
end
