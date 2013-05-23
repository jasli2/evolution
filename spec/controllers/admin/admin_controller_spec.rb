require 'spec_helper'

describe Admin::AdminController do

  describe "GET 'dashboard'" do
    it "returns http success" do
      get 'dashboard'
      response.should be_success
    end
  end

  describe "GET 'user'" do
    it "returns http success" do
      get 'user'
      response.should be_success
    end
  end

  describe "GET 'competency'" do
    it "returns http success" do
      get 'competency'
      response.should be_success
    end
  end

  describe "GET 'course'" do
    it "returns http success" do
      get 'course'
      response.should be_success
    end
  end

  describe "GET 'position'" do
    it "returns http success" do
      get 'position'
      response.should be_success
    end
  end

end
