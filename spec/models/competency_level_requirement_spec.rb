require 'spec_helper'

describe CompetencyLevelRequirement do
  it { should validate_presence_of :description }
  it { should belong_to :competency_level }
end
