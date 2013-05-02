require 'spec_helper'

describe User do
  it { should belong_to :manager }
  it { should have_many :subordinates }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should_not allow_value("blah").for(:email) }
  it { should allow_value("a@b.com").for(:email) }

  describe "factory" do
    it "should has a valid factory" do
      FactoryGirl.create(:user).should be_valid
    end
  end

  describe "validations" do  
    it "should has unique email address" do
      u = FactoryGirl.create(:user)
      FactoryGirl.build(:user, :email => u.email).should_not be_valid
    end
  end

  describe "suser helper function" do
    it "should returns a user's full name as 'first_name last_name'" do
      u = FactoryGirl.build(:user, :first_name => "hello", :last_name => "world")
      u.fullname.should == "hello world"
    end
  end
end
