require_relative '../lib/dish'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
	c.cassette_library_dir = 'spec/fixtures/dish_cassettes'
	c.hook_into :webmock
end