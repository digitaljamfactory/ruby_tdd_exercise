require_relative '../../spec_helper'

describe Dish::Player do

  let(:player) {Dish::Player.new('simplebits')}

  before do
    VCR.insert_cassette 'player', :record => :new_episodes
  end

  after do
    VCR.eject_cassette
  end

	it "must work" do
		"Yay!".must_be_instance_of String
	end

	describe "default attributes" do
		it "must include httparty methods" do
			Dish::Player.must_include HTTParty
		end

		it "must have the base url set to the dribble API endpoint" do
			Dish::Player.base_uri.must_equal 'http://api.dribbble.com'
		end

  end

  describe "GET profile" do



    it "must have a profile methode" do
      player.must_respond_to :profile
    end

    it "must parse the api response from JSON to Hash" do
      player.profile.must_be_instance_of Hash
    end

    it "must perfom the request and get the data" do
      player.profile["username"].must_equal 'simplebits'
    end

  end

  describe "default instance attributes" do

    it "must have an id attribute" do
      player.must_respond_to :username
    end

    it "must have the right id" do
      player.username.must_equal 'simplebits'
    end
  end

  describe "dynamic attributes" do


    before do
      player.profile
    end


    it "must return the atttribute value if present in the profile" do
      player.id.must_equal 1
    end

    it "must raise method missing if attribute is not present" do
      lambda {player.foo_attribute}.must_raise NoMethodError
    end
  end

  describe "caching" do

    before do
      player.profile
      stub_request(:any, /api.dribbble.com/).to_timeout
    end

    it "must cache the profile" do
      player.profile.must_be_instance_of Hash
    end

    it "must refresh the profile if forced" do
      lambda { player.profile(true)}.must_raise TimeoutError
    end

  end


end



