# == Schema Information
#
# Table name: competency_level_requirements
#
#  id                  :integer          not null, primary key
#  description         :string(255)
#  competency_level_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe CompetencyLevelRequirement do
  it { should validate_presence_of :description }
  it { should belong_to :competency_level }
end
