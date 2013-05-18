require 'spec_helper'

describe UsersController do

  describe "signup" do

    #before(:each) do
    #  visit '/signup'
    #end

    let(:submit) {"Create user account"}
    let(:user) {FactoryGirl.create(:user)}

=begin
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

    end
=end

    describe "with valid information" do
      it "should pass" do
        visit signup_path
        fill_in "user_first_name", :with => "long"
        fill_in "last_name", :with => user.last_name
        fill_in "email", :with => user.email
        fill_in "password", :with => user.password
        fill_in "password_confirmation", :with =>user.password_confirmation
      end
      end

=begin
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
=end

  end
end
