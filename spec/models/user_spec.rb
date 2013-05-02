require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without a firstname" do
    FactoryGirl.build(:user, :first_name => nil).should_not be_valid
  end

  it "is invalid without a lastname" do
    FactoryGirl.build(:user, :last_name => nil).should_not be_valid
  end

  it "returns a user's full name as a string" do
    u = FactoryGirl.build(:user, :first_name => "hello", :last_name => "world")
    u.fullname.should == "hello world"
  end

  it "is invalid if not a email address" do 
    FactoryGirl.build(:user, :email => "notvalide@email").should_not be_valid
  end

  it "is invalid if email address has been used" do
    u = FactoryGirl.create(:user)
    FactoryGirl.build(:user, :email => u.email).should_not be_valid
  end
end
