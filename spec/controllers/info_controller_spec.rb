require 'spec_helper'

describe InfoController do

  describe "GET 'couriers'" do
    it "should be successful" do
      get 'couriers'
      response.should be_success
    end
  end

  describe "GET 'businesses'" do
    it "should be successful" do
      get 'businesses'
      response.should be_success
    end
  end

  describe "GET 'private'" do
    it "should be successful" do
      get 'private'
      response.should be_success
    end
  end

end
