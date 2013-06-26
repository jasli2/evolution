require 'spec_helper'

describe TrainingPlan do
  it { should validate_presence_of :title }
  it { should validate_presence_of :feedback_deadline }
  it { should have_many :users }
  it { should have_many :courses }
  it { should have_many :feedbacks }
end
